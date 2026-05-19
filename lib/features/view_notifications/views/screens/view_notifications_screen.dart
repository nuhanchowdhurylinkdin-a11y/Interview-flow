import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/common/styles/global_text_style.dart';
import '../../controllers/view_notifications_controller.dart';
import '../../widgets/notification_card.dart';
import 'notification_details_screen.dart';

class ViewNotificationsScreen extends StatelessWidget {
  const ViewNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewNotificationsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Notifications', style: getTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.homeController.getNotification();
        },
        child: Obx(() {
          final isLoading = controller.homeController.isNotificationLoading.value;
          final list = controller.uiNotifications;

          return Column(
            children: [
              // Header Actions
              if (list.isNotEmpty || isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: isLoading ? null : () => controller.markAllAsRead(),
                        child: Text('Mark all as read', style: getTextStyle(fontSize: 14.sp, color: const Color(0xFF2D97C6))),
                      ),
                    ],
                  ),
                ),

              // Content
              Expanded(
                child: Skeletonizer(
                  enabled: isLoading,
                  child: list.isEmpty && !isLoading
                      ? _buildEmptyState()
                      : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: isLoading ? 6 : list.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      return NotificationCardWidget(
                        notification: isLoading ? _skeletonData() : list[index],
                        onTap: () {
                          if (!isLoading) {
                            // 1. Mark as read via API
                            if (!list[index].isRead) {
                              controller.markAsRead(list[index].id);
                            }

                            // 2. Navigate to Details
                            Get.to(() => NotificationDetailsScreen(notification: list[index]));
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 64.w, color: Colors.grey),
          SizedBox(height: 16.h),
          Text('No notifications yet', style: getTextStyle(fontSize: 16.sp, color: Colors.grey)),
        ],
      ),
    );
  }

  // Dummy data for skeleton layout
  dynamic _skeletonData() {
    return NotificationModel(
      id: '0', title: 'Notification Title Loading',
      description: 'This is a long description to fill the skeleton space properly.',
      timeAgo: '1h ago', iconType: 'bell', backgroundColor: '0xFFEEEEEE',
    );
  }
}