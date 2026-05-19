import 'package:dtc6464/features/interview_planner/controllers/interview_planner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/common/styles/global_text_style.dart';

class AddInterviewDateTimeSection extends StatelessWidget {
  final InterviewPlannerController controller;

  const AddInterviewDateTimeSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 24.h,
      children: [
        // Interview Date
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              'Interview Date',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF111827),
              ),
            ),
            Obx(() {
              return GestureDetector(
                onTap: () async {
                  final DateTime now = DateTime.now();
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value ?? now,
                    firstDate: now.isBefore(DateTime(2024)) ? DateTime(2024) : now,
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    controller.selectedDate.value = pickedDate;
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectedDate.value != null
                            ? DateFormat(
                                'MMM dd, yyyy',
                              ).format(controller.selectedDate.value!)
                            : 'Select date',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: controller.selectedDate.value != null
                              ? const Color(0xFF111827)
                              : const Color(0xFF9CA3AF),
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        size: 18.w,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
        // Time
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              'Time',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF111827),
              ),
            ),
            Obx(() {
              return GestureDetector(
                onTap: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime:
                        controller.selectedTime.value ?? TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    controller.selectedTime.value = pickedTime;
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectedTime.value != null
                            ? controller.selectedTime.value!.format(context)
                            : 'Select time',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: controller.selectedTime.value != null
                              ? const Color(0xFF111827)
                              : const Color(0xFF9CA3AF),
                        ),
                      ),
                      Icon(
                        Icons.access_time,
                        size: 18.w,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
