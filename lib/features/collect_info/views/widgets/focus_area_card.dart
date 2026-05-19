import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FocusAreaCard extends StatelessWidget {
  const FocusAreaCard({super.key, required this.title, required this.prepared});

  final String title;
  final int prepared;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20), // padding: 20
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // background: #FFF
        borderRadius: BorderRadius.circular(14), // border-radius: 14px
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF313131).withOpacity(0.08), // rgba(49, 49, 49, 0.08)
            offset: const Offset(0, 0), // 0 0
            blurRadius: 20, // 20px
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title section
          Text(
            title,
            overflow: TextOverflow.visible,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.softPurpleDarker,
            ),
          ),

          10.verticalSpace,

          Container(
            width: double.maxFinite,
            height: 5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.softPurpleLight,
            ),
            alignment: Alignment.centerLeft,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double parentWidth = constraints.maxWidth;
                double myPercentage = prepared.toDouble();
                double calculatedWidth = parentWidth * (myPercentage / 100);

                return AnimatedContainer(
                  // The duration of the sliding effect
                  duration: const Duration(milliseconds: 500),
                  // The "feel" of the animation (easeOut is smooth for progress bars)
                  curve: Curves.easeOutCubic,
                  height: 5.h,
                  width: calculatedWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.softPurpleNormal,
                  ),
                );
              },
            ),
          ),

          10.verticalSpace,

          Text(
            '$prepared% prepared',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF999EA7)
            ),
          )
        ],
      ),
    );
  }
}
