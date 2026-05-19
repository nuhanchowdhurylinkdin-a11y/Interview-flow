import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/features/onboarding/controllers/enter_name_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameFormWidget extends StatelessWidget {
  final EnterNameController controller;

  const NameFormWidget({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.whiteLight,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.softPurpleLight),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x14A0A0C8),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: controller.nameController,
                onChanged: (value) => controller.updateName(value),
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.softPurpleDarker,
                ),
                decoration: InputDecoration(
                  hintText: 'Your Full Name',
                  hintStyle: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.softPurpleNormalHover,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
          ),
          18.verticalSpace,
          Text(
            'We will use this to personalize your experience',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.softPurpleNormal,
            ),
          ),
        ],
      ),
    );
  }
}
