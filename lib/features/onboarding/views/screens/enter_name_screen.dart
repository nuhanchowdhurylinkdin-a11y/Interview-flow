import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/core/utils/constants/snackbar_constant.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/onboarding/controllers/enter_name_controller.dart';
import 'package:dtc6464/features/onboarding/widgets/enter_name_header.dart';
import 'package:dtc6464/features/onboarding/widgets/name_form_widget.dart';
import 'package:dtc6464/features/onboarding/widgets/progress_indicator.dart';
import 'package:dtc6464/features/onboarding/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../routes/app_routes.dart';

class EnterNameScreen extends StatelessWidget {
  const EnterNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EnterNameController());
    return Scaffold(
      body: Background(
        child: Obx(() {
          if(controller.isAvatarLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            );
          }
          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  60.verticalSpace,
                  const EnterNameHeader(),
                  56.verticalSpace,
                  const OnboardingProgressIndicator(),
                  24.verticalSpace,
                  const TitleWidget(title: 'What should I call you?'),
                  24.verticalSpace,
                  NameFormWidget(controller: controller),
                  30.verticalSpace,
                  // const EnterNameActionButton(),
                  CustomFilledButton(
                    text: 'Next',
                    onPressed: () {
                      if(controller.nameController.text.isEmpty) {
                        SnackBarConstant.error(title: "Name", message: "Please type your name to continue");
                        return;
                      }
                      Get.toNamed(AppRoute.avatarSelectionScreen);
                    },
                  ),
                  18.verticalSpace,
                  TextButton(onPressed: () => Get.back(), child: Text(
                    'Next',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.softPurpleNormal,
                    ),
                  )),
                  40.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 20.w),
            ),
          );
        }),
      ),
    );
  }
}
