import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/controller/collect_info_controller.dart';
import 'package:dtc6464/features/collect_info/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';

class Page7 extends StatelessWidget {
  Page7({super.key, required this.pageController, required this.controller});

  final CollectInfoController controller;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: 'Paste the job description',
              style: getTextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.softPurpleDarker,
              ),
              children: [
                TextSpan(
                  text: ' (Optional)',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          20.verticalSpace,

          CustomTextField(
            controller: controller.jobDescriptionController,
            hintText: "Paste the full job description here...",
            maxLine: 5,
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
