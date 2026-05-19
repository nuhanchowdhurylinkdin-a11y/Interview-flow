import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarProgressDots extends StatelessWidget {
  const AvatarProgressDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: AppColors.softPurpleNormal,
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        8.horizontalSpace,
        Container(
          width: 10.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: AppColors.softPurpleLight,
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
      ],
    );
  }
}
