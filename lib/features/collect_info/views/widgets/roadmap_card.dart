import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';

class RoadmapCard extends StatelessWidget {
  const RoadmapCard({super.key, required this.index, required this.title, required this.subTitle});

  final int index;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              // Using 24px as requested, which makes a 44x44 container circular
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF5A6BFF), // #5A6BFF at 0%
                  Color(0xFF7A86FF), // #7A86FF at 47.6%
                  Color(0xFF8A5CF6), // #8A5CF6 at 100%
                ],
                stops: [0.0, 0.476, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: getTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.whiteLight,
                ),
              ),
            ),
          ),

          12.horizontalSpace,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.visible,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.softPurpleDarker,
                  ),
                ),


                // Text(
                //   subTitle,
                //   overflow: TextOverflow.ellipsis,
                //   style: getTextStyle(
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.w400,
                //     color: Color(0xFF999EA7),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    ).paddingSymmetric(vertical: 10.h);
  }
}
