import 'package:dtc6464/features/learning_roadmap/model/roadmap_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../controllers/learning_roadmap_controller.dart';

class WeekCard extends StatelessWidget {

  final LearningArea item;

  const WeekCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          // Week header with icon, number, title
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12.w,
                children: [
                  // Container(
                  //   width: 46.w,
                  //   height: 46.w,
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xFFE0E3FF),
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: Center(
                  //     child: Icon(
                  //       _getIconForWeek(week.weekNumber),
                  //       color: const Color(0xFF8A5CF6),
                  //       size: 24.w,
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.h,
                      children: [
                        // Text(
                        //   week.weekLabel,
                        //   style: getTextStyle(
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeight.w500,
                        //     color: const Color(0xFF2D97C6),
                        //   ),
                        // ),
                        Text(
                          item.area.split('_')
                              .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
                              .join(' '),
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Progress bar with percentage
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12.w,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999.r),
                      child: LinearProgressIndicator(
                        value: item.progress,
                        minHeight: 4.h,
                        backgroundColor: const Color(0xFFD9D9D9),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF8A5CF6),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E3FF),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${item.progressPercentage}%',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Tags
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: item.topics
                .map(
                  (tag) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      tag,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF333333),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  IconData _getIconForWeek(int weekNumber) {
    switch (weekNumber) {
      case 1:
        return Icons.school;
      case 2:
        return Icons.computer;
      case 3:
        return Icons.business;
      case 4:
        return Icons.videocam;
      case 5:
        return Icons.trending_up;
      default:
        return Icons.info;
    }
  }
}
