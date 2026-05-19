import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/features/auth/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utils/constants/colors.dart';

class VerifyOtpScreen extends StatelessWidget {
  final bool isFromSignUp;
  VerifyOtpScreen({super.key, this.isFromSignUp = true});

  final SignUpController controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter the code sent to ${controller.emailController.text}",
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 30.h),

            OtpTextField(
              contentPadding: EdgeInsets.zero,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              numberOfFields: 6,
              borderRadius: BorderRadius.circular(10.0.r),
              fieldHeight: 42.0.w,
              fieldWidth: 42.0.w,
              borderColor: AppColors.softBlueNormal,
              showFieldAsBox: true,
              onSubmit: (verificationCode) {
                controller.otp = verificationCode;
              },
            ),

            SizedBox(height: 40.h),

            Obx(() => CustomFilledButton(text: 'Verify OTP', onPressed: () => controller.verifyOtp(true), isLoading: controller.isOtpLoading.value,)),
          ],
        ),
      ),
    );
  }
}