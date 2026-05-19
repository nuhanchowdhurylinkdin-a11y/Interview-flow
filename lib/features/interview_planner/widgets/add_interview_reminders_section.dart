import 'package:dtc6464/features/interview_planner/controllers/interview_planner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/common/styles/global_text_style.dart';

class AddInterviewRemindersSection extends StatelessWidget {
  final InterviewPlannerController controller;

  const AddInterviewRemindersSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          'Reminders',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF111827),
          ),
        ),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Remind me 1 day before',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.9,
                alignment: Alignment.centerRight,
                child: Switch.adaptive(
                  value: controller.oneDayReminderEnabled.value,
                  onChanged: (_) {
                    controller.oneDayReminderEnabled.value =
                        !controller.oneDayReminderEnabled.value;
                  },
                  activeThumbColor: Colors.white,
                  activeTrackColor: const Color(0xFFA78BFA),
                  inactiveTrackColor: const Color(0xFFF0F0F3),
                  inactiveThumbColor: Colors.white,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          );
        }),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Remind me 1 hour before',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.9,
                alignment: Alignment.centerRight,
                child: Switch.adaptive(
                  value: controller.oneHourReminderEnabled.value,
                  onChanged: (_) {
                    controller.oneHourReminderEnabled.value =
                        !controller.oneHourReminderEnabled.value;
                  },
                  activeThumbColor: Colors.white,
                  activeTrackColor: const Color(0xFFA78BFA),
                  inactiveTrackColor: const Color(0xFFF0F0F3),
                  inactiveThumbColor: Colors.white,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
