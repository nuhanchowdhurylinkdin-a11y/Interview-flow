import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressBarItem extends StatelessWidget {
  final String label;
  final String value;
  final double progress; // 0.0 to 1.0

  const ProgressBarItem({
    required this.label,
    required this.value,
    required this.progress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 1.75,
              ),
            ),
            Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xFF967DE1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 1.75,
              ),
            ),
          ],
        ),
        8.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6.h,
            backgroundColor: const Color(0xFFE4DBFD),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFA78BFA)),
          ),
        ),
      ],
    );
  }
}
