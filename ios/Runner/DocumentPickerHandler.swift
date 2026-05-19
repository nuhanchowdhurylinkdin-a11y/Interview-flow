import Flutter
import UIKit
import UniformTypeIdentifiers

class DocumentPickerHandler: NSObject, FlutterPlugin, UIDocumentPickerDelegate {
    private var pendingResult: FlutterResult?

    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "native_file_picker", binaryMessenger: registrar.messenger())
        let instance = DocumentPickerHandler()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "pickFile":
            pendingResult = result
            pickFile(call: call)
        case "listInboxFiles":
            listInboxFiles(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Document Picker (for real devices)

    private func pickFile(call: FlutterMethodCall) {
        let args = call.arguments as? [String: Any]
        let extensions = args?["extensions"] as? [String] ?? ["pdf", "doc", "docx"]

        var contentTypes: [UTType] = []
        for ext in extensions {
            if let utType = UTType(filenameExtension: ext) {
                contentTypes.append(utType)
            }
        }
        if contentTypes.isEmpty {
            contentTypes = [.item]
        }

        let picker = UIDocumentPickerViewController(forOpeningContentTypes: contentTypes, asCopy: true)
        picker.delegate = self
        picker.allowsMultipleSelection = false
        picker.modalPresentationStyle = .fullScreen

        if let viewController = Self.getTopViewController() {
            viewController.present(picker, animated: true, completion: nil)
        } else {
            pendingResult?(FlutterError(code: "NO_VC", message: "No view controller found", details: nil))
            pendingResult = nil
        }
    }

    // MARK: - Direct file listing (fallback for simulator)

    private func listInboxFiles(result: @escaping FlutterResult) {
        var files: [[String: Any]] = []
        let fm = FileManager.default

        // Check Documents/Inbox (where "Open in..." files go)
        if let docsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
            let inboxDir = docsDir.appendingPathComponent("Inbox")
            if let contents = try? fm.contentsOfDirectory(at: inboxDir, includingPropertiesForKeys: [.fileSizeKey]) {
                for url in contents {
                    let attrs = try? fm.attributesOfItem(atPath: url.path)
                    let size = (attrs?[.size] as? Int) ?? 0
                    files.append([
                        "path": url.path,
                        "name": url.lastPathComponent,
                        "size": size
                    ])
                }
            }
        }

        // Also check tmp directory
        let tmpDir = fm.temporaryDirectory
        if let contents = try? fm.contentsOfDirectory(at: tmpDir, includingPropertiesForKeys: [.fileSizeKey]) {
            for url in contents {
                let ext = url.pathExtension.lowercased()
                if ["pdf", "doc", "docx"].contains(ext) {
                    let attrs = try? fm.attributesOfItem(atPath: url.path)
                    let size = (attrs?[.size] as? Int) ?? 0
                    files.append([
                        "path": url.path,
                        "name": url.lastPathComponent,
                        "size": size
                    ])
                }
            }
        }

        result(files)
    }

    private static func getTopViewController() -> UIViewController? {
        var rootVC: UIViewController?

        for scene in UIApplication.shared.connectedScenes {
            if let windowScene = scene as? UIWindowScene,
               scene.activationState == .foregroundActive {
                rootVC = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController
                    ?? windowScene.windows.first?.rootViewController
                break
            }
        }

        var top = rootVC
        while let presented = top?.presentedViewController {
            top = presented
        }
        return top
    }

    // MARK: - UIDocumentPickerDelegate

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            pendingResult?(nil)
            pendingResult = nil
            return
        }

        let tempDir = FileManager.default.temporaryDirectory
        let tempFile = tempDir.appendingPathComponent(url.lastPathComponent)
        try? FileManager.default.removeItem(at: tempFile)

        do {
            // asCopy: true means the file is already copied, but handle both cases
            if url.path.hasPrefix(tempDir.path) {
                // Already in temp
                let attrs = try? FileManager.default.attributesOfItem(atPath: url.path)
                let size = (attrs?[.size] as? Int) ?? 0
                pendingResult?([
                    "path": url.path,
                    "name": url.lastPathComponent,
                    "size": size
                ])
            } else {
                try FileManager.default.copyItem(at: url, to: tempFile)
                let attrs = try? FileManager.default.attributesOfItem(atPath: tempFile.path)
                let size = (attrs?[.size] as? Int) ?? 0
                pendingResult?([
                    "path": tempFile.path,
                    "name": url.lastPathComponent,
                    "size": size
                ])
            }
        } catch {
            pendingResult?(FlutterError(code: "COPY_ERROR", message: error.localizedDescription, details: nil))
        }
        pendingResult = nil
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        pendingResult?(nil)
        pendingResult = nil
    }
}
