import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:dtc6464/core/utils/constants/image_path.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/controller/collect_info_controller.dart';
import 'package:dtc6464/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProfileAnalyzing extends StatefulWidget {
  const ProfileAnalyzing({super.key});

  @override
  State<ProfileAnalyzing> createState() => _ProfileAnalyzingState();
}

class _ProfileAnalyzingState extends State<ProfileAnalyzing> {
  final CollectInfoController controller = Get.find<CollectInfoController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.analyzeProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              120.verticalSpace,

              Image.asset(IconPath.ai, height: 80.h),

              40.verticalSpace,

              Text(
                'Analyzing your profile..',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.softPurpleDarker,
                ),
              ),

              12.verticalSpace,

              Text(
                'Building your personalized roadmap',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.softPurpleDarker,
                ),
              ),

              40.verticalSpace,

              Lottie.asset(ImagePath.aiLogo2, height: 130.h),

              40.verticalSpace,

              for (int i = 0; i < 4; i++)
                Row(
                  children: [
                    Image.asset(IconPath.verify, width: 20.w),
                    8.horizontalSpace,
                    Text(
                      i == 0
                          ? 'Analyzing your role and goals'
                          : i == 1
                          ? "Extracting skills from resume"
                          : i == 2
                          ? "Matching with job requirements"
                          : "Generating personalized questions",
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.softPurpleDarker,
                      ),
                    ),
                  ],
                ).paddingOnly(left: 32.w, bottom: 8.h),
            ],
          ).paddingSymmetric(horizontal: 16.w),
        ),
      ),
    );
  }
}
