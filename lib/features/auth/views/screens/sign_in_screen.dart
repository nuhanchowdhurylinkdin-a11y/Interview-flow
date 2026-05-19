import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/core/common/widgets/legal_links_section.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:dtc6464/core/utils/constants/image_path.dart';
import 'package:dtc6464/features/auth/controller/sign_in_controller.dart';
import 'package:dtc6464/features/auth/views/screens/sign_up_screen.dart';
import 'package:dtc6464/features/auth/views/widgets/sign_in_with.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/views/widgets/custom_text_field.dart';
import 'package:dtc6464/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/services/storage_service.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController controller = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              80.verticalSpace,

              // logo
              Image.asset(ImagePath.logo, height: 100.h),

              10.verticalSpace,

              Text(
                "Walk Into Every Interview knowing Exactly What To Say",
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.softPurpleDarker,
                )
              ),

              Text(
                'Sign In',
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.softPurpleDarker,
                ),
              ),

              20.verticalSpace,

              // email
              CustomTextField(
                controller: controller.emailController,
                hintText: "Email",
              ),

              10.verticalSpace,

              // password
              Obx(
                () => CustomTextField(
                  controller: controller.passwordController,
                  hintText: "Password",
                  obscureText: !controller.isPasswordVisible.value,
                  suffixIcon: IconButton(
                    onPressed: () => controller.togglePasswordVisibility(),
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              20.verticalSpace,

              // submit
              Obx(() {
                return CustomFilledButton(
                  text: 'Sign In',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.login();
                  },
                );
              }),

              10.verticalSpace,

              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Get.toNamed(AppRoute.resetPasswordScreen),
                  child: Text(
                    'Reset Password',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      color: AppColors.softBlueNormal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              10.verticalSpace,

              // seperate lines
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.softBlueNormal)),
                  Text(
                    'or',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.softBlueNormal,
                    ),
                  ).paddingSymmetric(horizontal: 13.sp),
                  Expanded(child: Divider(color: AppColors.softBlueNormal)),
                ],
              ),

              20.verticalSpace,

              SignInWith(icon: IconPath.google, methodNane: "Google"),
              15.verticalSpace,

              SignInWith(icon: IconPath.linkedin, methodNane: "LinkedIn"),

              20.verticalSpace,

              InkWell(
                onTap: () {
                  final userProfileId = StorageService.userProfileId;
                  if(userProfileId == null) {
                    Get.toNamed(AppRoute.collectInfoScreen);
                  } else {
                    Get.toNamed(AppRoute.getSignUpScreen());
                  }
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: getTextStyle(
                            fontSize: 14.sp,
                            color: AppColors.softPurpleDarker,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Sign Up",
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

              30.verticalSpace,

              const LegalLinksSection(),

              20.verticalSpace,
            ],
          ).paddingSymmetric(horizontal: 26.w),
        ),
      ),
    );
  }
}
