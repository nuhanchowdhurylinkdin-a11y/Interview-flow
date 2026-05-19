import 'package:get/get.dart';

import '../../../core/services/network_caller.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/api_constants.dart';
import '../../../core/utils/constants/snackbar_constant.dart';
import '../../../core/utils/logging/logger.dart';
import '../../home/controller/home_screen_controller.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String timeAgo;
  final String iconType; // bell, calendar, trend, bulb, target, chat
  final String backgroundColor;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.iconType,
    required this.backgroundColor,
    this.isRead = false,
  });
}

class ViewNotificationsController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();
  // Reference the home controller where getNotification() lives
  final HomeScreenController homeController = Get.find<HomeScreenController>();

  // This will be our UI-friendly list
  RxList<NotificationModel> uiNotifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch fresh data when screen opens
    homeController.getNotification().then((_) => _mapNotifications());
  }

  void _mapNotifications() {
    final apiData = homeController.notifications.value?.data ?? [];

    uiNotifications.value = apiData.map((node) {
      return NotificationModel(
        id: node.id,
        title: node.title,
        description: node.message,
        // Helper to format "2023-10-10" to "1h ago"
        timeAgo: _formatTimeAgo(node.createdAt),
        iconType: _determineIcon(node.title),
        backgroundColor: _determineColor(node.title),
        isRead: node.isRead,
      );
    }).toList();
  }

  String _formatTimeAgo(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inDays > 0) return '${duration.inDays}d ago';
    if (duration.inHours > 0) return '${duration.inHours}h ago';
    if (duration.inMinutes > 0) return '${duration.inMinutes}m ago';
    return 'Just now';
  }

  String _determineIcon(String title) {
    if (title.contains('Practice')) return 'bell';
    if (title.contains('Tip')) return 'bulb';
    return 'target';
  }

  String _determineColor(String title) {
    if (title.contains('Practice')) return '0xFFE8EAF6';
    return '0xFFF3E5F5';
  }

  Future<bool> markNotificationAsRead(String id) async {
    try {
      final token = StorageService.accessToken;
      // The screenshot shows the ID is a path parameter
      final response = await _networkCaller.patchRequest(
        "${ApiConstant.baseUrl}${ApiConstant.markAsRead}$id",
        body: {},
        token: token,
      );

      if (response.isSuccess) {
        AppLoggerHelper.info('✅ Notification $id marked as read');
        return true;
      } else {
        AppLoggerHelper.error('❌ Failed to mark as read: ${response.errorMessage}');
        return false;
      }
    } catch (e) {
      AppLoggerHelper.error('❌ Error marking notification as read: $e');
      return false;
    }
  }

  Future<bool> markAllNotificationAsRead() async {
    try {
      final token = StorageService.accessToken;
      // The screenshot shows the ID is a path parameter
      final response = await _networkCaller.patchRequest(
        ApiConstant.baseUrl + ApiConstant.markAllAsRead,
        body: {},
        token: token,
      );

      if (response.isSuccess) {
        AppLoggerHelper.info('✅ Notification all marked as read');
        return true;
      } else {
        AppLoggerHelper.error('❌ Failed to mark all as read: ${response.errorMessage}');
        return false;
      }
    } catch (e) {
      AppLoggerHelper.error('❌ Error marking notification all as read: $e');
      return false;
    }
  }

  void markAsRead(String id) async {
    final index = uiNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      uiNotifications[index].isRead = true;
      uiNotifications.refresh();
      final success = await markNotificationAsRead(id);
      if (!success) {
        uiNotifications[index].isRead = false;
        uiNotifications.refresh();
        SnackBarConstant.errorThin(title: "Error", message: "Could not update notification status");
      }
    }
  }

  void markAllAsRead() async {
    for (var n in uiNotifications) {
      n.isRead = true;
    }
    uiNotifications.refresh();
    final success = await markAllNotificationAsRead();
    if (!success) {
      for (var n in uiNotifications) {
        n.isRead = false;
      }
      uiNotifications.refresh();
      SnackBarConstant.errorThin(title: "Error", message: "Could not update all notification status");
    }
  }
}
