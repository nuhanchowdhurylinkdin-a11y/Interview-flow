import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/features/bottom_nav_bar/controller/bottom_nav_bar_conroller.dart';
import 'package:dtc6464/features/home/views/screens/practice_mode_screen.dart';
import 'package:dtc6464/features/practice/views/screens/select_interview.dart';
import 'package:dtc6464/features/pro_tips/views/screens/pro_tips_screen.dart';
import 'package:dtc6464/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class QuickAction extends StatelessWidget {
  QuickAction({super.key});
  
  final BottomNavBarController controller = Get.find<BottomNavBarController>();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              child: GestureDetector(
                onTap: () => AppHelperFunctions.navigateToScreen(context, PracticeModeScreen()),
                child: ActionCard(
                  icon: IconPath.micColor,
                  title: "Start Practice",
                  subtitle: "AI-powered Q&A",
                  subTitleColor: const Color(0xFF2D97C6),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD0F1FF), Color(0xFFB3E8FF)],
                  ),
                ),
              ),
            ),

            8.horizontalSpace,

            Expanded(
              child: GestureDetector(
                onTap: () => AppHelperFunctions.navigateToScreen(context, ProTipsScreen()),
                child: ActionCard(
                  icon: IconPath.bulb,
                  title: "Pro Tips",
                  subtitle: "Expert advice",
                  subTitleColor: const Color(0xFFF97316),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter, // 0%
                    end: Alignment.bottomCenter, // 100%
                    colors: [Color(0xFFFFDDC8), Color(0xFFFFECC3)],
                  ),
                ),
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.jumpToScreen(3),
                child: ActionCard(
                  icon: IconPath.group,
                  title: "Learning Roadmap",
                  subtitle: "Skill development",
                  subTitleColor: const Color(0xFFEC4899),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter, // 0%
                    end: Alignment.bottomCenter, // 100%
                    colors: [Color(0xFFFFD4D9), Color(0xFFFFC8E3)],
                  ),
                ),
              ),
            ),

            8.horizontalSpace,

            Expanded(
              child: GestureDetector(
                onTap: () => controller.jumpToScreen(1),
                child: ActionCard(
                  icon: IconPath.planner,
                  title: "Interview Planner",
                  subtitle: "Schedule & track",
                  subTitleColor: const Color(0xFF8A5CF6),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter, // 0%
                    end: Alignment.bottomCenter, // 100%
                    colors: [Color(0xFFDFD3FD), Color(0xFFCED3FF)],
                  ),
                ),
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
    required this.subtitle,
    required this.gradient,
    required this.subTitleColor,
  });

  final String icon;
  final String title;
  final String subtitle;
  final Color subTitleColor;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: gradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38.h,
            width: 38.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Image.asset(icon, height: 26.h),
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
              color: subTitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
