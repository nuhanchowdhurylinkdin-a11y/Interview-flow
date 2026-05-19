import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsCard extends StatelessWidget {
  final Widget child;

  const NotificationsCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E3FF).withValues(alpha: 0.8),
            blurRadius: 12.r,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
