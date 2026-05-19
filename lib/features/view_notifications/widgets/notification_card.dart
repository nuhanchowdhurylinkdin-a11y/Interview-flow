import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';

class NotificationCardWidget extends StatelessWidget {
  final dynamic notification;
  final VoidCallback onTap;

  const NotificationCardWidget({super.key, required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isRead = notification.isRead;
    final bgColor = Color(int.parse(notification.backgroundColor));

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isRead ? 0.6 : 1.0, // Visual "Read" effect
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: isRead ? null : Border.all(color: AppColors.softPurpleNormal.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isRead ? 0.02 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Section
              Container(
                width: 40.w, height: 40.w,
                decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                child: Icon(Icons.notifications, size: 20.w, color: AppColors.softPurpleNormal),
              ),
              SizedBox(width: 12.w),
              // Content Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (!isRead) // Red dot for unread
                          Container(
                            margin: EdgeInsets.only(right: 6.w),
                            width: 8.w, height: 8.w,
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          ),
                        Expanded(
                          child: Text(
                            notification.title,
                            overflow: TextOverflow.ellipsis,
                            style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4A4A6A)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      notification.description,
                      style: getTextStyle(fontSize: 12.sp, color: const Color(0xFF9B9BAA)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                notification.timeAgo,
                style: getTextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: const Color(0xFFA78BFA)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}