import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/features/auth/controller/forgor_password_controller.dart';
import 'package:dtc6464/features/auth/controller/reset_password_controller.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/custom_filled_button.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../../../routes/app_routes.dart';
import '../../../collect_info/views/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

  final screenHeight = AppHelperFunctions.screenHeight();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              80.verticalSpace,

              // logo
              Image.asset(ImagePath.logo, height: 120.h),

              40.verticalSpace,

              Text(
                'Sign In',
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.softPurpleDarker,
                ),
              ),

              20.verticalSpace,

              Text(
                'Enter your Email address to receive a verification code.',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B6B8A),
                ),
              ),

              20.verticalSpace,

              // email
              CustomTextField(
                controller: controller.emailController,
                hintText: "Email",
              ),

              20.verticalSpace,

              Obx(
                () => CustomFilledButton(
                  text: 'Send Code',
                  onPressed: () => controller.forgotPassword(),
                  isLoading: controller.isForgotPasswordLoading.value,
                ),
              ),

              20.verticalSpace,

              InkWell(
                onTap: () {
                  Get.offAllNamed(AppRoute.getSignInScreen());
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Remember Password? ",
                          style: getTextStyle(
                            fontSize: 14.sp,
                            color: AppColors.softPurpleDarker,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.softBlueDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              40.verticalSpace,

              Text(
                'Terms of Use and Privacy Policy',
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.softPurpleDarker,
                ),
              ),

              20.verticalSpace,
            ],
          ).paddingSymmetric(horizontal: 26.w),
        ),
      ),
    );
  }
}
