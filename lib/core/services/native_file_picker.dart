import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeFilePicker {
  static const _channel = MethodChannel('native_file_picker');

  /// Picks a file on iOS. First tries the native document picker.
  /// If that fails or is cancelled, offers to pick from inbox files.
  static Future<Map<String, dynamic>?> pickFile({
    List<String> extensions = const ['pdf', 'doc', 'docx'],
  }) async {
    if (!Platform.isIOS) return null;

    try {
      final result = await _channel.invokeMethod<Map>('pickFile', {
        'extensions': extensions,
      });
      if (result != null) return Map<String, dynamic>.from(result);
    } catch (e) {
      debugPrint('Native picker error: $e');
    }

    return null;
  }

  /// Lists files available in the app's Inbox/tmp directories.
  /// Useful as fallback when document picker doesn't work (e.g. simulator).
  static Future<List<Map<String, dynamic>>> listAvailableFiles() async {
    if (!Platform.isIOS) return [];

    try {
      final result = await _channel.invokeMethod<List>('listInboxFiles');
      if (result != null) {
        return result.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
    } catch (e) {
      debugPrint('listInboxFiles error: $e');
    }
    return [];
  }

  /// Shows a bottom sheet with available files from the app's inbox.
  /// Returns selected file info or null if cancelled.
  static Future<Map<String, dynamic>?> pickFromInbox(BuildContext context) async {
    final files = await listAvailableFiles();
    if (files.isEmpty) return null;

    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Select a file', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...files.map((file) {
                final name = file['name'] as String;
                final size = file['size'] as int;
                final sizeStr = '${(size / 1024).toStringAsFixed(1)} KB';
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file),
                  title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(sizeStr),
                  onTap: () => Navigator.pop(ctx, file),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
