import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../controller/collect_info_controller.dart';
import '../widgets/custom_text_field.dart';

class Page2 extends StatelessWidget {
  const Page2({
    super.key,
    required this.pageController,
    required this.controller,
  });

  final CollectInfoController controller;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'What role are you preparing for?',
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.softPurpleDarker,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: getTextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            20.verticalSpace,

            CustomTextField(
              controller: controller.rolePreparingController,
              hintText: "e.g., Senior Product Manager",
              suffixIcon: IconButton(
                icon: Icon(Icons.add_circle_outline, color: AppColors.softPurpleDarker),
                onPressed: controller.addTargetRole,
              ),
            ),

            12.verticalSpace,

            Obx(
              () => Wrap(
                spacing: 8.w,
                runSpacing: 10.h,
                children: controller.targetRoles.map((role) {
                  return Chip(
                    label: Text(
                      role,
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.softPurpleDarker,
                      ),
                    ),
                    deleteIcon: Icon(Icons.close, size: 18.sp),
                    onDeleted: () => controller.removeTargetRole(role),
                    backgroundColor: const Color(0xFFF3EEFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: const BorderSide(color: Color(0xFFA78BFA)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
