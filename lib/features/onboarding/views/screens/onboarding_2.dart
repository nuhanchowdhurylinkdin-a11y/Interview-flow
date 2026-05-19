import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/core/common/widgets/legal_links_section.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/constants/image_path.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              80.verticalSpace,
              // logo and text logo
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // logo
                  Image.asset(ImagePath.logo, width: 60.w),

                  15.horizontalSpace,
                  // text logo and punch line
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(ImagePath.textLogo, width: 195.w),
                      10.verticalSpace,
                      Text(
                        'Your AI Interview Assistant',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.softBlueNormal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              25.verticalSpace,

              // robot message image
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(ImagePath.roboatMessage, width: 175.w),
              ),

              // robot head
              Image.asset(ImagePath.roboatHead, width: 103.w),

              30.verticalSpace,

              Text(
                "InterviewFlo is an AI interview coaching app that generates personalized questions, evaluates your responses instantly, and provides sample answers to help you prepare confidently.",
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.softPurpleDarker,
                ),
              ),

              40.verticalSpace,

              // get started button
              CustomFilledButton(
                text: 'Get Started',
                onPressed: () => Get.toNamed(AppRoute.getCollectInfoScreen()),
                isIcon: true,
              ),

              12.verticalSpace,

              // sign in button
              Container(
                height: 52.h,
                width: double.maxFinite,
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.r),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.7, -0.6),
                    end: Alignment(0.7, 0.6),
                    colors: [Color(0xFFA78BFA), Color(0xFF5835C0)],
                    stops: [0.1541, 0.8459],
                  ),
                ),

                child: GestureDetector(
                  onTap: () => Get.offAllNamed(AppRoute.signInScreen),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.r),
                      color: AppColors.whiteLight,
                    ),
                  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.softPurpleDarker,
                          ),
                        ),
                  
                        Text(
                          'Sign In',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.tealBlueNormal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              12.verticalSpace,

              Text(
                'Join thousands preparing for their dream job',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.softPurpleNormal,
                ),
              ),

              30.verticalSpace,

              const LegalLinksSection(),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ),
      ),
    );
  }
}
