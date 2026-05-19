import 'package:dtc6464/features/interview_planner/controllers/interview_planner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/styles/global_text_style.dart';

class AddInterviewActionButtons extends StatelessWidget {
  final InterviewPlannerController controller;
  final VoidCallback onAddToCalendar;
  final VoidCallback onSaveInterview;

  const AddInterviewActionButtons({
    super.key,
    required this.controller,
    required this.onAddToCalendar,
    required this.onSaveInterview,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.w,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onAddToCalendar,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE4DBFD),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8.w,
                children: [
                  Flexible(
                    child: Text(
                      'Add to Calendar',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: getTextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8A5CF6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onSaveInterview,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.00, 0.50),
                  end: Alignment(1.00, 0.50),
                  colors: [Color(0xFFA78BFA), Color(0xFF5734C0)],
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8.w,
                children: [
                  Flexible(
                    child: Text(
                      'Save Interview',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: getTextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
