import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationToggleItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String iconPath;
  final bool isEnabled;
  final VoidCallback onToggle;

  const NotificationToggleItem({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.iconPath,
    required this.isEnabled,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.w,
            children: [
              Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    width: 16.w,
                    height: 16.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: const Color(0xFF4A4A6A),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.7,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(0xFF9B9BAA),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.75,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        12.horizontalSpace,
        SizedBox(
          width: 56.w,
          child: Transform.scale(
            scale: 0.95,
            alignment: Alignment.centerRight,
            child: Switch.adaptive(
              value: isEnabled,
              onChanged: (_) => onToggle(),
              activeThumbColor: Colors.white, // thumb color when active
              activeTrackColor: const Color(0xFFA78BFA),
              inactiveTrackColor: const Color(0xFFF0F0F3),
              inactiveThumbColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],
    );
  }
}
