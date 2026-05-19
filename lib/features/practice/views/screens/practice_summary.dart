import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/practice/views/screens/select_interview.dart';
import 'package:dtc6464/features/practice/views/screens/view_detailed_feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/custom_filled_button.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/helpers/app_helper.dart';
import '../../controller/practice_controller.dart';

class PracticeSummary extends StatelessWidget {
  PracticeSummary({super.key});

  final PracticeController controller = Get.find<PracticeController>();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            'Practice Summary',
            style: getTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Image.asset(
                IconPath.bell,
                height: 30.h,
              ).paddingOnly(right: 15.w),
            ),
          ],
        ),
        body: Obx(() {
          final bool isLoading = controller.isSubmitAnswerLoading.value;
          final overall = controller.analizeData.value?.data.aiData.overallPerformance;

          return Skeletonizer(
            enabled: isLoading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.verticalSpace,

                  // Identifier (Tags)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTag(controller.selectedIndex.value == 1 ? "Non-Technical" : "Technical Interview", isGradient: true),
                      // 10.horizontalSpace,
                      // _buildTag(controller.selectedTopic.value, isGradient: false),
                    ],
                  ),

                  40.verticalSpace,

                  // Dynamic Score
                  Container(
                    height: 140.h,
                    width: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000.r),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFFFDDC8), Color(0xFFFFECC3)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD2B3),
                          offset: const Offset(0, 4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${overall?.rating ?? 0}/10',
                      style: getTextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF97316),
                      ),
                    ),
                  ),

                  20.verticalSpace,

                  Text(
                    'Overall Performance',
                    style: getTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF97316)),
                  ),

                  40.verticalSpace,

                  // Strengths Section
                  if (overall?.strengths != null)
                    _buildFeedbackCard(
                      title: 'Strengths',
                      icon: IconPath.strength,
                      iconBgColor: const Color(0xFFE4DBFD),
                      items: overall!.strengths,
                    ),

                  10.verticalSpace,

                  // Areas to Improve Section
                  if (overall?.areasToImprove != null)
                    _buildFeedbackCard(
                      title: 'Areas to Improve',
                      icon: IconPath.bulbUpdated,
                      iconBgColor: const Color(0xFFC1EBFD),
                      items: overall!.areasToImprove,
                    ),

                  40.verticalSpace,

                  CustomFilledButton(
                    text: 'View Detailed Feedback',
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFDDC8), Color(0xFFFFECC3)],
                    ),
                    textColor: const Color(0xFFF97316),
                    onPressed: () {
                      AppHelperFunctions.navigateToScreen(context, ViewDetailedFeedbackScreen());
                    },
                  ).paddingSymmetric(horizontal: 35.w),

                  20.verticalSpace,

                  CustomFilledButton(
                    text: 'Practice Next Question',
                    onPressed: () {
                      controller.nextQuestion();
                      Navigator.pop(context);
                    },
                  ).paddingSymmetric(horizontal: 35.w),

                  10.verticalSpace,

                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SelectInterview()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      'Back To Home',
                      style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.softPurpleNormalActive),
                    ),
                  ),

                  60.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ),
          );
        }),
      ),
    );
  }


  Widget _buildTag(String text, {required bool isGradient}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFA896E6).withOpacity(0.30)),
        gradient: isGradient
            ? LinearGradient(
          colors: [
            const Color(0xFFA896E6).withOpacity(0.20),
            const Color(0xFFB8D4F1).withOpacity(0.20),
          ],
        )
            : null,
        color: isGradient ? null : Colors.white,
      ),
      child: Text(
        text,
        style: getTextStyle(fontSize: 12.sp, color: const Color(0xFF4A4A6A)),
      ),
    );
  }

  Widget _buildFeedbackCard({
    required String title,
    required String icon,
    required Color iconBgColor,
    required List<String> items,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A5CF6).withOpacity(0.20),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 32.h, width: 32.w,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBgColor,
                ),
                child: Image.asset(icon),
              ),
              12.horizontalSpace,
              Text(
                title,
                style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.softPurpleNormalHover),
              )
            ],
          ),
          15.verticalSpace,
          ...items.map((text) => Padding(
            padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 7.h, width: 7.w,
                  margin: EdgeInsets.only(top: 7.h),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF8A5CF6),
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: Text(
                    text,
                    style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.softPurpleNormalHover),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
