import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/bottom_nav_bar/controller/bottom_nav_bar_conroller.dart';
import 'package:dtc6464/features/home/controller/home_screen_controller.dart';
import 'package:dtc6464/features/home/views/widgets/what_you_will_get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../routes/app_routes.dart';
import '../../model/progress_model.dart';

class PracticeModeScreen extends StatelessWidget {
  PracticeModeScreen({super.key});
  
  final BottomNavBarController controller = Get.find<BottomNavBarController>();
  final HomeScreenController _controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 80.h),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,

            // 1. Disable the automatic back button
            automaticallyImplyLeading: false,

            // 2. Set width to 0 to remove the reserved space
            leadingWidth: 0,

            // 3. Keep leading as null or remove the leading property entirely
            leading: null,
            title: Text(
              'Welcome back!',
              style: getTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.softPurpleDarker,
              ),
            ),
            actions: [
              InkWell(
                onTap: () => Get.toNamed(AppRoute.viewNotificationsScreen),
                child: Image.asset(IconPath.notification),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size(double.maxFinite, 30.h),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Ready to ace your next interview?',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.softPurpleDarkerHover,
                  ),
                ).paddingOnly(left: 16.w),
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              20.verticalSpace,

              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(30.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  // Gradient: 180deg (Top to Bottom)
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF8B5CF6), // #8B5CF6 at 0%
                      Color(0xFF8B5CF6), // #8B5CF6 at 47.6%
                      Color(0xFFFF78BB), // #FF78BB at 100%
                    ],
                    stops: [0.0, 0.476, 1.0], // Matching your percentages
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000.r),

                        // 2. Background: rgba(255, 255, 255, 0.40)
                        color: Colors.white.withOpacity(0.60),

                        // 3. Box Shadow: 0 4px 20px 0 rgba(138, 92, 246, 0.60)
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: const Color(0xFF8A5CF6).withOpacity(0.60), // rgba(138, 92, 246, 0.60)
                        //     offset: const Offset(0, 4), // x: 0, y: 4
                        //     blurRadius: 20,             // blur: 20
                        //     spreadRadius: 0,            // spread: 0
                        //   ),
                        // ],
                      ),
                      alignment: AlignmentGeometry.center,
                      child: Image.asset(IconPath.microphone, color: Colors.white, height: 54.h,),
                    ),

                    15.verticalSpace,

                    Text(
                      'Start New Practice Session',
                      textAlign: TextAlign.center,
                      style: getTextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    5.verticalSpace,

                    Text(
                      "Get 10 personalized Questions with AL evaluation",
                      textAlign: TextAlign.center,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),

                    20.verticalSpace,

                    GestureDetector(
                      onTap: () => controller.jumpToScreen(2),
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000.r),
                          color: Colors.white.withOpacity(0.60),
                        ),
                        alignment: AlignmentGeometry.center,
                        child: Image.asset(IconPath.arrowRightFilled, color: Colors.white, height: 15.h,),
                      ),
                    ),
                  ],
                ),
              ),

              40.verticalSpace,

              WhatYouWillGet(),

              40.verticalSpace,

              // progress
              Obx(() {
                final bool isLoading = _controller.isProgressLoading.value;
                final progress = _controller.progress.value;


                if(_controller.isProgressError.value) {
                  return _buildErrorWidget(title: 'Progress',  gradient: const LinearGradient(
                    begin: Alignment.topCenter, // 0%
                    end: Alignment.bottomCenter, // 100%
                    colors: [Color(0xFFFFDDC8), Color(0xFFFFECC3)],
                  ),);
                }
                return Skeletonizer(enabled: isLoading, child: Progress(data: progress ?? _controller.getProgressPlaceholderData(),));
              }),

              40.verticalSpace,
            ],
          ).paddingSymmetric(horizontal: 16.w),
        ),
      ),
    );
  }

  Widget _buildErrorWidget({
    required String title,
    required LinearGradient gradient,
  }) {
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
          Text(
            title,
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          20.verticalSpace,

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Icon(
                  Icons.inventory_2_outlined,
                  size: 25.sp,
                  color: Colors.red,
                ),

                10.verticalSpace,

                Text(
                  "No data found",
                  style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                Text(
                  "Pull to refresh",
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),

              ],
            ),
          ),

          SizedBox(width: 80.w),
        ],
      ),
    );
  }

}

class Progress extends StatelessWidget {
  const Progress({super.key, required this.data});

  final ProgressModel data;

  @override
  Widget build(BuildContext context) {
    final item = data.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        12.verticalSpace,

        Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.476, 1.0],
              colors: [Color(0xFF5A6BFF), Color(0xFF7A86FF), Color(0xFF8A5CF6)],
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      item.yourScore.toString(),
                      style: getTextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    5.verticalSpace,

                    Text(
                      'Your Score',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.white, width: 2.w),
                    right: BorderSide(color: Colors.white, width: 2.w),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "${item.avgScore.toStringAsFixed(2)}%",
                      style: getTextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    5.verticalSpace,

                    Text(
                      'Avg Score',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      item.streak.toString(),
                      style: getTextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    5.verticalSpace,

                    Text(
                      'Streak',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

