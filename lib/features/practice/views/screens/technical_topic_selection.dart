import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:dtc6464/features/practice/views/screens/ai_coach_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/custom_filled_button.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../background/views/widgets/background.dart';
import '../../controller/practice_controller.dart';

class TechnicalTopicSelection extends StatelessWidget {
  TechnicalTopicSelection({super.key});

  final PracticeController controller = Get.find<PracticeController>();

  final List<Map<String, dynamic>> categories = [
    {
      "title": "technical_questions",
      "subtitle": "Concepts, algorithms, data structures",
      "icon": Icons.code,
      "bgColor": const Color(0xFFE0E7FF), // Soft Blue
      "iconColor": const Color(0xFF818CF8),
    },
    {
      "title": "technical_behavioral",
      "subtitle": "Past experiences in technical roles",
      "icon": Icons.groups_rounded,
      "bgColor": const Color(0xFFEDE9FE), // Soft Purple
      "iconColor": const Color(0xFFA78BFA),
    },
    {
      "title": "technical_case_study",
      "subtitle": "Hypothetical problem-solving scenario",
      "icon": Icons.description,
      "bgColor": const Color(0xFFFCE7F3), // Soft Pink
      "iconColor": const Color(0xFFF472B6),
    },
    {
      "title": "technical_system_design",
      "subtitle": "Architecture and scalability",
      "icon": Icons.memory,
      "bgColor": const Color(0xFFFEF3C7), // Soft Amber
      "iconColor": const Color(0xFFFBBF24),
    },
    {
      "title": "technical_hiring_manager",
      "subtitle": "Timed rapid-fire practice",
      "icon": Icons.timer,
      "bgColor": const Color(0xFFDCFCE7), // Soft Green
      "iconColor": const Color(0xFF4ADE80),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
            'Select Topic',
            style: getTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: const Color(0xFF333333))
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            20.verticalSpace,

            Text(
              'Choose a category to begin',
              style: getTextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B6B8A)
              ),
            ),
            10.verticalSpace,
            // Loop through the map
            ...categories.map((data) => buildCategoryCard(data, context)).toList(),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget buildCategoryCard(Map<String, dynamic> data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectedTopic.value = data['title'];
        controller.startInterview(context);
        AppHelperFunctions.navigateToScreen(context, AiCoachMode());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: data['bgColor'],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            // Circular Icon Container
            Container(
              height: 60.h,
              width: 60.h,
              decoration: BoxDecoration(
                color: data['iconColor'].withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(data['icon'], color: data['iconColor'], size: 28.sp),
            ),
            16.horizontalSpace,
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'].split('_')
                        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
                        .join(' '),
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    data['subtitle'],
                    style: getTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Right Arrow
            Icon(Icons.chevron_right, color: Colors.black26, size: 24.sp),
            8.horizontalSpace,
          ],
        ),
      ),
    );
  }
}