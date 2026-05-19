import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/features/nav_screens/profile/notifications/model/notfication_settings_model.dart';
import 'package:get/get.dart';

import '../../../../../core/services/storage_service.dart';
import '../../../../../core/utils/constants/snackbar_constant.dart';

class NotificationsController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  // Observables for UI
  final practiceReminders = true.obs;
  final interviewReminders = true.obs;
  final weeklyProgressSummary = true.obs;
  final tipsRecommendations = true.obs;

  RxBool isNotificationSettingsLoading = false.obs;
  RxBool isNotificationSettingsError = false.obs;
  Rx<NotificationSettingsModel?> notificationSettings = Rx<NotificationSettingsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getNotificationSettings();
  }

  Future<void> getNotificationSettings() async {
    try {
      isNotificationSettingsLoading.value = true;
      isNotificationSettingsError.value = false;

      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.notificationSettings,
        token: StorageService.accessToken,
      );

      if (!response.isSuccess) {
        isNotificationSettingsError.value = true;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }

      final model = NotificationSettingsModel.fromJson(response.responseData);
      notificationSettings.value = model;

      // Sync local toggles with API data
      practiceReminders.value = model.data.practiceReminders;
      interviewReminders.value = model.data.interviewReminders;
      weeklyProgressSummary.value = model.data.weeklyProgressSummary;
      tipsRecommendations.value = model.data.tipsAndRecommendations;

    } catch (e) {
      isNotificationSettingsLoading.value = false;
      isNotificationSettingsError.value = true;
      SnackBarConstant.errorThin(title: 'Failed', message: e.toString());
    } finally {
      isNotificationSettingsLoading.value = false;
    }
  }

  /// Updates settings on the server when a toggle is switched
  Future<void> updateSettings() async {
    try {
      final response = await _networkCaller.patchRequest(
        ApiConstant.baseUrl + ApiConstant.notificationSettings, // Adjust endpoint if different
        body: {
          "practiceReminders": practiceReminders.value,
          "interviewReminders": interviewReminders.value,
          "weeklyProgressSummary": weeklyProgressSummary.value,
          "tipsAndRecommendations": tipsRecommendations.value,
        },
        token: StorageService.accessToken,
      );

      if (!response.isSuccess) {
        SnackBarConstant.error(title: 'Update Failed', message: response.errorMessage);
        // Optional: revert local toggle state on failure
      }

    } catch (e) {
      SnackBarConstant.errorThin(title: 'Error', message: e.toString());
    }
  }

  void togglePracticeReminders() {
    practiceReminders.value = !practiceReminders.value;
    updateSettings();
  }

  void toggleInterviewReminders() {
    interviewReminders.value = !interviewReminders.value;
    updateSettings();
  }

  void toggleWeeklyProgressSummary() {
    weeklyProgressSummary.value = !weeklyProgressSummary.value;
    updateSettings();
  }

  void toggleTipsRecommendations() {
    tipsRecommendations.value = !tipsRecommendations.value;
    updateSettings();
  }
}
