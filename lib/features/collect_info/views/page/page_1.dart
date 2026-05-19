import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/controller/collect_info_controller.dart';
import 'package:dtc6464/features/collect_info/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';

class Page1 extends StatelessWidget {
  Page1({super.key, required this.pageController, required this.controller});

  final CollectInfoController controller;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: 'What is your current role?',
              style: getTextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.softPurpleDarker,
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: getTextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          20.verticalSpace,

          CustomTextField(
            controller: controller.roleController,
            hintText: "e.g., Software Engineer",
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
