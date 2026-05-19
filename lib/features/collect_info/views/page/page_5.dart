import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/controller/collect_info_controller.dart';
import 'package:dtc6464/features/collect_info/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/goal_selection_card.dart';

class Page5 extends StatelessWidget {
  Page5({super.key, required this.pageController, required this.controller});

  final CollectInfoController controller;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: 'What are your career goals?',
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

          8.verticalSpace,

          Text(
            'Select up to 3',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.softBlueDark,
            ),
          ),

          20.verticalSpace,

          Expanded(
            child: ListView.builder(
              itemCount: controller.goals.length,
              padding: EdgeInsets.only(bottom: 20.h),
              itemBuilder: (context, index) {
                final goal = controller.goals[index];

                // Wrap only the card in Obx so it listens to selection changes
                return Obx(() {
                  final isSelected = controller.selectedGoals.contains(goal);

                  return GoalSelectionCard(
                    text: goal,
                    imagePath: controller.goalsIcon[index],
                    isSelected: isSelected,
                    onTap: () => controller.toggleGoal(goal),
                  );
                });
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
