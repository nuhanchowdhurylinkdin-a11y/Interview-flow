import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:dtc6464/features/auth/controller/sign_up_controller.dart';
import 'package:dtc6464/features/auth/views/screens/otp_screen.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/custom_filled_button.dart';
import '../../../../core/common/widgets/legal_links_section.dart';
import '../../../../core/common/widgets/terms_checkbox.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../../../routes/app_routes.dart';
import '../../../collect_info/views/widgets/custom_text_field.dart';
import '../widgets/sign_in_with.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              80.verticalSpace,

              // logo
              Image.asset(ImagePath.logo, height: 120.h,),

              40.verticalSpace,

              Text(
                'Sign Up',
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.softPurpleDarker,
                ),
              ),

              20.verticalSpace,

              // email
              CustomTextField(controller: controller.emailController, hintText: "Email"),

              10.verticalSpace,

              // password
              Obx(() => CustomTextField(
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
              )),

              10.verticalSpace,

              // confirm password
              Obx(() => CustomTextField(
                controller: controller.confirmPasswordController,
                hintText: "Confirm password",
                obscureText: !controller.isConfirmPasswordVisible.value,
                suffixIcon: IconButton(
                  onPressed: () => controller.togglePasswordVisibility(),
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              )),

              20.verticalSpace,

              Obx(() => TermsCheckbox(
                value: controller.isTermsAccepted.value,
                onChanged: controller.toggleTermsAccepted,
              )),

              20.verticalSpace,

              Obx(() => CustomFilledButton(text: 'Sign Up', onPressed: () => controller.signUp(context), isLoading: controller.isSignUpLoading.value,),),

              // seperate lines
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.softBlueNormal,)),
                  Text(
                    'or',
                    style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.softBlueNormal
                    ),
                  ).paddingSymmetric(horizontal: 13.sp),
                  Expanded(child: Divider(color: AppColors.softBlueNormal,)),
                ],
              ),

              20.verticalSpace,

              SignInWith(icon: IconPath.google, methodNane: "Google",),
              15.verticalSpace,

              SignInWith(icon: IconPath.linkedin, methodNane: "LinkedIn",),

              20.verticalSpace,

              InkWell(
                onTap: () {
                  Get.back();
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
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
