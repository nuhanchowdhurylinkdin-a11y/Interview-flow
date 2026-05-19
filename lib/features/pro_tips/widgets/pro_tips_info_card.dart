import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';

class ProTipsInfoCard extends StatelessWidget {
  const ProTipsInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12.h,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.softPurpleNormal.withValues(alpha: 0.1),
            ),
            child: Center(
              child: Image.asset(
                IconPath.bulb,
                height: 48.w,
                color: const Color(0xFFFFA500),
              ),
            ),
          ),
          Text(
            'Pro Tips for Success',
            textAlign: TextAlign.center,
            style: getTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          Text(
            'Master these essential interview tips to boost your confidence and performance',
            textAlign: TextAlign.center,
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF999EA7),
              lineHeight: 1.75,
            ),
          ),
        ],
      ),
    );
  }
}
