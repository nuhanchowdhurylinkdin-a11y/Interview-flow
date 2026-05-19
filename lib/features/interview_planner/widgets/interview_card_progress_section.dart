import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/styles/global_text_style.dart';

class InterviewCardProgressSection extends StatelessWidget {
  final double preparationProgress;

  const InterviewCardProgressSection({
    super.key,
    required this.preparationProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Preparation Progress',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333),
              ),
            ),
            Text(
              '${(preparationProgress * 100).toInt()}%',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8A5CF6),
              ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: LinearProgressIndicator(
            value: preparationProgress,
            minHeight: 6.h,
            backgroundColor: const Color(0xFFE4DBFD),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFA78BFA)),
          ),
        ),
      ],
    );
  }
}
