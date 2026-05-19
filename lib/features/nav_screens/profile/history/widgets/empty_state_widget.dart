import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const EmptyStateWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        80.verticalSpace,
        Icon(Icons.description_outlined, size: 64.sp, color: Colors.grey[300]),
        24.verticalSpace,
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF333333),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        12.verticalSpace,
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF999EA7),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
