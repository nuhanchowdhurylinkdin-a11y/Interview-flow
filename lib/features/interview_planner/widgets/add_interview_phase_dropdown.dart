import 'package:dtc6464/features/interview_planner/controllers/interview_planner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/common/styles/global_text_style.dart';

class AddInterviewPhaseDropdown extends StatelessWidget {
  final InterviewPlannerController controller;

  const AddInterviewPhaseDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          'Interview Phase',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF111827),
          ),
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButton<String>(
              value: controller.selectedPhase.value,
              items: controller.interviewPhases
                  .map(
                    (phase) =>
                        DropdownMenuItem(value: phase, child: Text(phase)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedPhase.value = value;
                }
              },
              isExpanded: true,
              underline: const SizedBox(),
              hint: Text(
                'Select phase',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
