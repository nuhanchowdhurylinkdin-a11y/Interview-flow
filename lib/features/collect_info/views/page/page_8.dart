import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/controller/collect_info_controller.dart';
import 'package:dtc6464/features/collect_info/views/widgets/custom_text_field.dart';
import 'package:dtc6464/features/collect_info/views/widgets/upload_resume_cad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';

class Page8 extends StatelessWidget {
  Page8({super.key, required this.pageController, required this.controller});

  final CollectInfoController controller;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: 'Upload Resume',
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.softPurpleDarker,
                ),
                children: [
                  TextSpan(
                    text: ' (Optional)',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
        
            10.verticalSpace,
            Text(
              'You can upload up to 3 resumes',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.softPurpleDarker,
              ),
            ),
        
            40.verticalSpace,
        
            for(int i = 0; i < 3; i++)
              Obx(() => UploadResumeCad(
                text: "Upload Resume ${i+1}",
                fileName: controller.resumes[i+1]?.name,
                fileSize: controller.resumes[i+1]?.size,
                onTap: () => controller.pickResume(i+1),
                onDelete: () => controller.resumes[i+1] = null,
              )),
        
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
