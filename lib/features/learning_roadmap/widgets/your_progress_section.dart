import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../controllers/learning_roadmap_controller.dart';

class YourProgressSection extends StatelessWidget {
  const YourProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LearningRoadmapController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Obx(() {
        final roadmapData = controller.roadmap.value;
        final bool isLoading = controller.isRoadMapLoading.value;

        final int progress = (roadmapData == null) ? 0 : roadmapData.data.overallProgress;

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12.h,
          children: [
            Text(
              'Your Progress',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF999EA7),
              ),
            ),

            Text(
              '$progress%',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 38.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8A5CF6),
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(999.r),
              child: LinearProgressIndicator(
                value: isLoading ? null : progress / 100,
                minHeight: 4.h,
                backgroundColor: const Color(0xFFD9D9D9),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF8A5CF6),
                ),
              ),
            ),

            Text(
              controller.motivationalMessage.value,
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF999EA7),
              ),
            ),
          ],
        );
      }),
    );
  }
}
