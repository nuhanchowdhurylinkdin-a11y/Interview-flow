import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/core/utils/constants/image_path.dart';
import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/controller/collect_info_controller.dart';
import 'package:dtc6464/features/collect_info/views/widgets/focus_area_card.dart';
import 'package:dtc6464/features/collect_info/views/widgets/question_card.dart';
import 'package:dtc6464/features/collect_info/views/widgets/roadmap_card.dart';
import 'package:dtc6464/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../../core/utils/constants/colors.dart';

class AiBrief extends StatelessWidget {
  AiBrief({super.key});

  final CollectInfoController controller = Get.find<CollectInfoController>();

  @override
  Widget build(BuildContext context) {
    final data = controller.aiBriefData.value!.data.aiData;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // banner
              Image.asset(ImagePath.banner, fit: BoxFit.cover),

              60.verticalSpace,

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    'Your ${data.roadmap.duration.value}-${AppHelperFunctions.capitalize(data.roadmap.duration.unit)} Roadmap',
                    style: getTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.softPurpleDarker,
                    ),
                  ),

                  20.verticalSpace,

                  // road nap
                  Container(
                    padding: const EdgeInsets.all(20), // Padding: 20
                    decoration: BoxDecoration(
                      color: Colors.white, // background: #FFF
                      borderRadius: BorderRadius.circular(
                        14,
                      ), // border-radius: 14px
                      boxShadow: [
                        BoxShadow(
                          // rgba(49, 49, 49, 0.08)
                          color: const Color(0xFF313131).withOpacity(0.08),
                          offset: const Offset(0, 0), // 0 0
                          blurRadius: 20, // 20px
                          spreadRadius: 0, // 0
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < data.roadmap.plan.length; i++)
                          RoadmapCard(
                            index: i + 1,
                            title: data.roadmap.plan[i].focus,
                            subTitle: '',
                          ),
                      ],
                    ),
                  ),

                  20.verticalSpace,

                  //Key Focus Areas
                  Text(
                    'Key Focus Areas',
                    style: getTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.softPurpleDarker,
                    ),
                  ),

                  16.verticalSpace,

                  for (int i = 0; i < data.keyFocusAreas.length; i++)
                    FocusAreaCard(
                      title:
                          "${data.keyFocusAreas[i].area.replaceAll('_', ' ')[0].toUpperCase()}${data.keyFocusAreas[i].area.replaceAll('_', ' ').substring(1).toLowerCase()}",
                      prepared: (data.keyFocusAreas[i].progress * 100).toInt(),
                    ).paddingOnly(bottom: 10.h),

                  20.verticalSpace,

                  // Sample Question for you
                  Text(
                    'Sample Question for you',
                    style: getTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.softPurpleDarker,
                    ),
                  ),

                  16.verticalSpace,

                  for(int i = 0; i < data.sampleQuestions.length; i++)
                    QuestionCard(
                      question:
                      data.sampleQuestions[i].text,
                    ).paddingOnly(bottom: 10.h),



                  20.verticalSpace,

                  // benchmark
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 45.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        14,
                      ), // border-radius: 14px
                      gradient: const LinearGradient(
                        begin: Alignment(
                          -1.0,
                          -0.2,
                        ), // Approximating 95 degrees
                        end: Alignment(1.0, 0.2),
                        colors: [
                          Color(0xFF5A6BFF), // #5A6BFF at 0.5%
                          Color(0xFF7A85FF), // #7A85FF at 45.26%
                          Color(0xFF8A5CF6), // #8A5CF6 at 94.54%
                        ],
                        stops: [
                          0.005,
                          0.4526,
                          0.9454,
                        ], // Mapping percentages to 0.0 - 1.0
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Your Benchmark',
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.whiteLight,
                          ),
                        ),

                        20.verticalSpace,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  data.benchmarkScore.current.toString(),
                                  style: getTextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.whiteLight,
                                  ),
                                ),

                                Text(
                                  'Your Score',
                                  style: getTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteLight,
                                    lineHeight: 0.8,
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              height: 75.h,
                              width: 2,
                              color: AppColors.whiteLight,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  data.benchmarkScore.target.toString(),
                                  style: getTextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.whiteLight,
                                  ),
                                ),

                                Text(
                                  'Target Score',
                                  style: getTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteLight,
                                    lineHeight: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  20.verticalSpace,

                  CustomFilledButton(
                    text: 'Save My Plan',
                    isIcon: true,
                    onPressed: () {
                      Get.offAllNamed(AppRoute.getSignUpScreen());
                    },
                  ),

                  20.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ],
          ),
        ),
      ),
    );
  }
}
