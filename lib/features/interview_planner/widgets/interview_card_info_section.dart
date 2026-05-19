import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/styles/global_text_style.dart';

class InterviewCardInfoSection extends StatelessWidget {
  final DateTime interviewDate;
  final String round;
  final bool reminderBeforeOneDay;
  final bool reminderBeforeOneHour;

  const InterviewCardInfoSection({
    super.key,
    required this.interviewDate,
    required this.round,
    required this.reminderBeforeOneDay,
    required this.reminderBeforeOneHour,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 6.w,
          children: [
            Icon(
              Icons.calendar_today,
              size: 12.w,
              color: const Color(0xFF929294),
            ),
            Flexible(
              child: Text(
                DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(interviewDate),
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF929294),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.w,
          children: [
            Icon(
              Icons.calendar_today,
              size: 12.w,
              color: const Color(0xFF929294),
            ),
            Flexible(
              child: Text(
                round,
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF929294),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 6.w,
          children: [
            Icon(
              Icons.calendar_today,
              size: 12.w,
              color: const Color(0xFF929294),
            ),
            Flexible(
              child: Text(
                'Reminder before one day: $reminderBeforeOneDay',
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF929294),
                ),
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 6.w,
          children: [
            Icon(
              Icons.calendar_today,
              size: 12.w,
              color: const Color(0xFF929294),
            ),
            Flexible(
              child: Text(
                'Reminder before one hour: $reminderBeforeOneHour',
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF929294),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
