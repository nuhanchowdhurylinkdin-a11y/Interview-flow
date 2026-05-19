import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:dtc6464/core/utils/constants/image_path.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Onboarding1 extends StatelessWidget {
  Onboarding1({super.key});

  final OnboardingController controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: Column(
            children: [

              80.verticalSpace,

              // robot image
              Image.asset(ImagePath.roboatHead, height: 144.h,),

              30.verticalSpace,

              // text logo
              Image.asset(ImagePath.textLogo, width: 191.w,),

              20.verticalSpace,

              // punch line
              Text(
                'Your Al-Powered Interview Coach',
                style: getTextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.softBlueNormal,
                ),
              ),

              20.verticalSpace,


              // components
              for(int i = 0; i < 3; i++)
                Container(
                  height: 52.h,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColors.whiteLight,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.softPurpleLight)
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ai icon
                      Image.asset( i == 0 ? IconPath.ai : i == 1 ? IconPath.status : IconPath.cup, width: 24.w,),

                      10.horizontalSpace,

                      Text(
                        i == 0 ? 'Al-Powered Practice': i == 1 ? 'Track Your Progress' : 'Ace Your Interview',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.softPurpleNormalHover,
                        ),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 10.h),


              // progress bar

              Spacer(),

              Container(
                height: 10.h,
                width: 240.w,
                decoration: BoxDecoration(
                  color: AppColors.whiteLight,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                alignment: Alignment.centerLeft,
                child: Obx(
                        () {
                    return Container(
                      height: 10.h,
                      width: controller.progressWidth.value,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF2D97C6), // 0%
                            Color(0xFF38BDF8), // 50%
                            Color(0xFF2D97C6), // 100%
                          ],
                          stops: [0.0, 0.5, 1.0], // Defines where each color sits
                        ),
                      ),
                    );
                  }
                ),
              ),

              70.verticalSpace,
            ],
          ).paddingSymmetric(horizontal: 26.w),
        ),
      ),
    );
  }
}
