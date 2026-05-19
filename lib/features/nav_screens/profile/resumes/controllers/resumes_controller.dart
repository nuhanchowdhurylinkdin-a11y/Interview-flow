import 'dart:io';

import 'package:dtc6464/core/services/native_file_picker.dart';
import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/constants/snackbar_constant.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ResumeItem {
  final String url;
  final String filename;

  ResumeItem({required this.url, required this.filename});

  factory ResumeItem.fromJson(Map<String, dynamic> json) => ResumeItem(
        url: json['url'] ?? '',
        filename: json['filename'] ?? 'Resume',
      );
}

class ResumesController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  RxList<ResumeItem> resumes = <ResumeItem>[].obs;
  RxBool isLoading = false.obs;
  RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchResumes();
  }

  Future<void> fetchResumes() async {
    try {
      isLoading.value = true;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.resumes,
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        final data = response.responseData['data'];
        if (data != null && data['resumes'] != null) {
          resumes.assignAll(
            (data['resumes'] as List).map((e) => ResumeItem.fromJson(e)).toList(),
          );
          AppLoggerHelper.info('Loaded ${resumes.length} resumes');
        }
      }
    } catch (e) {
      AppLoggerHelper.error('Error fetching resumes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addResume() async {
    try {
      String? filePath;
      String fileName = '';
      String fileExt;

      if (Platform.isIOS) {
        final result = await NativeFilePicker.pickFile();
        if (result == null) return;
        filePath = result['path'] as String;
        fileName = result['name'] as String;
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx'],
        );
        if (result == null) return;
        filePath = result.files.first.path;
        fileName = result.files.first.name;
      }

      if (filePath == null) return;

      fileExt = fileName.contains('.')
          ? fileName.split('.').last.toLowerCase()
          : '';
      if (!['pdf', 'doc', 'docx'].contains(fileExt)) {
        SnackBarConstant.error(
          title: 'Invalid File',
          message: 'Please select a PDF, DOC, or DOCX file',
        );
        return;
      }

      isUploading.value = true;

      final response = await _networkCaller.postMultipartRequest(
        ApiConstant.baseUrl + ApiConstant.resume,
        fields: {},
        filePaths: [filePath],
        token: StorageService.accessToken,
        fileFieldName: 'resume',
      );

      if (response.isSuccess) {
        SnackBarConstant.success(title: 'Success', message: 'Resume uploaded');
        await fetchResumes();
      } else {
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
      }
    } catch (e) {
      AppLoggerHelper.error('Error uploading resume: $e');
      SnackBarConstant.error(title: 'Error', message: 'Failed to upload resume');
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> deleteResume(int index) async {
    try {
      isLoading.value = true;
      final resumeUrl = resumes[index].url;

      final response = await _networkCaller.deleteRequest(
        ApiConstant.baseUrl + ApiConstant.resume,
        body: {'resumeUrl': resumeUrl},
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        resumes.removeAt(index);
        SnackBarConstant.success(title: 'Success', message: 'Resume removed');
      } else {
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
      }
    } catch (e) {
      AppLoggerHelper.error('Error deleting resume: $e');
      SnackBarConstant.error(title: 'Error', message: 'Failed to delete resume');
    } finally {
      isLoading.value = false;
    }
  }
}
