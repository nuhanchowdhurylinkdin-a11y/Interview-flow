import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question});

  final String question;

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
      
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(IconPath.question, width: 18.w,).paddingOnly(top: 5.h),
          10.horizontalSpace,
          Expanded(
            child: Text(
              question,
              overflow: TextOverflow.visible,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.softPurpleDarker
              ),
            ),
          )
        ],
      ),
    );
  }
}
