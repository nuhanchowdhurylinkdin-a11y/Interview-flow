import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/icon_path.dart';
class WhatYouWillGet extends StatelessWidget {
  const WhatYouWillGet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        12.verticalSpace,

        Row(
          children: [
            Expanded(
              child: ActionCard(
                icon: IconPath.bulb,
                title: "Personalized Questions",
                subtitle: "Al generates questions based on your profile and goals",
                color: const Color(0xFFFFDFC9),
                iconColor: const Color(0xFFF97316),
              ),
            ),

            8.horizontalSpace,

            Expanded(
              child: ActionCard(
                icon: IconPath.microphone,
                title: "Voice & Text",
                subtitle: "Practice speaking or typing your responses",
                color: const Color(0xFFCAEFFF),
                iconColor: const Color(0xFF38BDF8),
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Row(
          children: [
            Expanded(
              child: ActionCard(
                icon: IconPath.group,
                title: "Detailed Feedback",
                subtitle: "Get STAR analysis, scores, and improvement tips",
                color: Color(0xFFEC4899).withOpacity(0.2),
                iconColor: const Color(0xFFEC4899),
              ),
            ),

            8.horizontalSpace,

            Expanded(
              child: ActionCard(
                icon: IconPath.planner,
                title: "Track Progress",
                subtitle: "View comprehensive session summaries and trends",
                color: Color(0xFF8A5CF6).withOpacity(0.2),
                iconColor: const Color(0xFF8A5CF6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle, this.iconColor, this.color,
  });

  final String icon;
  final String title;
  final String subtitle;
  final Color? iconColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 195.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38.h,
            width: 38.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Image.asset(icon, height: 26.h, color: iconColor,),
          ),
          8.verticalSpace,
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          4.verticalSpace,

          Text(
            subtitle,
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }
}