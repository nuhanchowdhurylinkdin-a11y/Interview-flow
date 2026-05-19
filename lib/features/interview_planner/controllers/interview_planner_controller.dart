import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/features/interview_planner/model/interviews_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/api_constants.dart';
import '../../../core/utils/constants/snackbar_constant.dart';
import '../../../core/utils/logging/logger.dart';

class InterviewPlannerController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getInterviews();
  }

  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  final companyNameController = TextEditingController();
  final roleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final noteController = TextEditingController();

  final selectedDate = Rx<DateTime?>(null);
  final selectedTime = Rx<TimeOfDay?>(null);
  final selectedPhase = Rx<String?>('1st Round');
  var selectedStatus = 'Scheduled'.obs;

  final oneDayReminderEnabled = true.obs;
  final oneHourReminderEnabled = false.obs;
  final isAddInterviewLoading = false.obs;
  RxBool isInterviewPlansLoading = false.obs;
  RxBool isInterviewPlansError = false.obs;
  RxBool isChangeInterviewStatusLoading = false.obs;

  Rx<InterviewsModel?> interviews = Rx<InterviewsModel?>(null);

  void changeStatus(String status, String id) {
    selectedStatus.value = status;
    changeInterviewStatus(status, id);
  }

  final interviewPhases = [
    '1st Round',
    '2nd Round',
    '3rd Round',
    'Technical Interview',
    'Behavioral Interview',
    'Final Round',
  ];

  late final DateTime combinedDateTime = DateTime(
    selectedDate.value!.year,
    selectedDate.value!.month,
    selectedDate.value!.day,
    selectedTime.value!.hour,
    selectedTime.value!.minute,
  );

  Future<void> addInterview() async {
    try {
      isAddInterviewLoading.value = true;
      final token = StorageService.accessToken;

      final response = await _networkCaller.postRequest(
        ApiConstant.baseUrl + ApiConstant.addInterview,
        body: {
          "companyName": companyNameController.text,
          "jobTitle": roleController.text,
          "jobDescription": jobDescriptionController.text,
          "interviewDate": selectedDate.value!.toIso8601String(),
          "interviewTime": combinedDateTime.toUtc().toIso8601String(),
          "interviewPhase": selectedPhase.value ?? '',
          "note": noteController.text,
          "oneDayBeforeReminder": oneDayReminderEnabled.value,
          "oneHourBeforeReminder": oneHourReminderEnabled.value,
        },
      );

      if (!response.isSuccess) {
        isAddInterviewLoading.value = false;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }

      isAddInterviewLoading.value = false;
      Get.back();
      getInterviews();
    } catch (e) {
      isAddInterviewLoading.value = false;
      SnackBarConstant.errorThin(title: 'Failed', message: e.toString());
    } finally {
      isAddInterviewLoading.value = false;
    }
  }

  Future<void> getInterviews() async {
    try {
      isInterviewPlansLoading.value = true;
      final token = StorageService.accessToken;
      interviews.value = null;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.interviewsPlans,
        token: token,
      );

      if (!response.isSuccess) {
        isInterviewPlansLoading.value = false;
        isInterviewPlansError.value = true;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }

      interviews.value = InterviewsModel.fromJson(response.responseData);

      interviews.refresh();

      isInterviewPlansLoading.value = false;
      isInterviewPlansError.value = false;
    } catch (e) {
      isInterviewPlansLoading.value = false;
      isInterviewPlansError.value = true;
      SnackBarConstant.errorThin(title: 'Failed', message: e.toString());
    } finally {
      isInterviewPlansLoading.value = false;
    }
  }

  Future<void> changeInterviewStatus(String status, String id) async {
    try {
      AppLoggerHelper.debug('This is working');
      isChangeInterviewStatusLoading.value = true;
      final token = StorageService.accessToken;
      final response = await _networkCaller.patchRequest(
        "${ApiConstant.baseUrl}/interview/plan/$id/status",
        body: {"status": status.toUpperCase()},
        token: token,
      );

      if (!response.isSuccess) {
        isChangeInterviewStatusLoading.value = false;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }

      isChangeInterviewStatusLoading.value = false;
      await getInterviews();
    } catch (e) {
      isChangeInterviewStatusLoading.value = false;
      SnackBarConstant.errorThin(title: 'Failed', message: e.toString());
    } finally {
      isChangeInterviewStatusLoading.value = false;
    }
  }

  Datum getPlaceholderInterview() {
    return Datum(
      id: "0",
      companyName: "Loading Company",
      jobTitle: "Software Engineer",
      jobDescription: "",
      interviewDate: DateTime.now(),
      interviewTime: DateTime.now(),
      interviewPhase: "1st Round",
      note: "",
      status: "SCHEDULED",
      preparationProgress: 0,
      oneDayBeforeReminder: true,
      oneHourBeforeReminder: false,
      userId: "",
    );
  }

  void clearForm() {
    companyNameController.clear();
    roleController.clear();
    jobDescriptionController.clear();
    noteController.clear();
    selectedDate.value = null;
    selectedTime.value = null;
    selectedPhase.value = '1st Round';
    oneDayReminderEnabled.value = true;
    oneHourReminderEnabled.value = false;
  }

  String getAvatarInitials(String name) {
    return name.isNotEmpty ? name[0].toUpperCase() : '';
  }

  String getStatusColor(String status) {
    switch (status) {
      case 'SCHEDULED':
        return '0xFFE1F5FE';
      case 'COMPLETED':
        return '0xFFE8F5E9';
      case 'CANCELLED':
        return '0xFFFFEBEE';
      default:
        return '0xFFE1F5FE';
    }
  }

  String getStatusTextColor(String status) {
    switch (status) {
      case 'SCHEDULED':
        return '0xFF2A8EBA';
      case 'COMPLETED':
        return '0xFF2E7D32';
      case 'CANCELLED':
        return '0xFFC62828';
      default:
        return '0xFF2A8EBA';
    }
  }

  @override
  void onClose() {
    companyNameController.dispose();
    roleController.dispose();
    jobDescriptionController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
