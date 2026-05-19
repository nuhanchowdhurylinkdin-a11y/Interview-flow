import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/practice/views/screens/non_technical_selection.dart';
import 'package:dtc6464/features/practice/views/screens/technical_topic_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/constants/icon_path.dart';
import '../../controller/practice_controller.dart';

class SelectInterview extends StatelessWidget {
  SelectInterview({super.key});

  final PracticeController controller = Get.find<PracticeController>();

  @override
  Widget build(BuildContext context) {
    // Fetch resumes and roles when screen is opened
    controller.fetchResumes();
    controller.fetchRoles();

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Select Interview Type',
            style: getTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              controller.fetchResumes(),
              controller.fetchRoles(),
            ]);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Obx(
              () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,

                // --- Resume Selection ---
                Text(
                  'Select Resume',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                10.verticalSpace,
                _buildResumeSelection(),

                20.verticalSpace,

                // --- Role Selection (Dropdown) ---
                Text(
                  'Select Role',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                10.verticalSpace,
                _buildRoleDropdown(),

                24.verticalSpace,

                // --- Interview Type Section ---
                Text(
                  'Interview Type',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                16.verticalSpace,

                // --- Technical Interview Card ---
                buildInterviewCard(
                  index: 0,
                  icon: IconPath.arrows,
                  title: 'Technical Interview',
                  subtitle: 'Coding challenges, algorithms, system design',
                ),

                20.verticalSpace,

                // --- Non-Technical Interview Card ---
                buildInterviewCard(
                  index: 1,
                  icon: IconPath.users,
                  title: 'Non-Technical / Behavioral Interview',
                  subtitle: 'STAR method, soft skills, past experiences',
                ),

                40.verticalSpace,
                CustomFilledButton(
                  text: "Continue",
                  onPressed: () {
                    if (controller.selectedResumeIndex.value == -1) {
                      Get.snackbar('Required', 'Please select a resume',
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }
                    if (controller.selectedRole.value.isEmpty) {
                      Get.snackbar('Required', 'Please select a role',
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }

                    if (controller.selectedIndex.value == 0) {
                      AppHelperFunctions.navigateToScreen(
                        context,
                        TechnicalTopicSelection(),
                      );
                    } else {
                      AppHelperFunctions.navigateToScreen(
                        context,
                        NonTechnicalTopicSelection(),
                      );
                    }
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 16.w),
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildResumeSelection() {
    if (controller.isResumesLoading.value) {
      return Skeletonizer(
        enabled: true,
        child: Column(
          children: List.generate(2, (_) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFFE4DBFD)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.description, size: 22.sp),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    'Resume_placeholder.pdf',
                    style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )),
        ),
      );
    }

    if (controller.resumes.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE4DBFD)),
        ),
        child: Text(
          'No resumes found. Please upload a resume from your profile.',
          style: getTextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
      );
    }

    return Column(
      children: List.generate(controller.resumes.length, (index) {
        final resume = controller.resumes[index];
        final fileName = resume.filename;
        final isSelected = controller.selectedResumeIndex.value == index;

        return InkWell(
          onTap: () => controller.selectedResumeIndex.value = index,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF6F3FF) : Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isSelected
                    ? AppColors.softPurpleNormalActive
                    : const Color(0xFFE4DBFD),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.softPurpleNormalActive.withValues(alpha: 0.15)
                        : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.description,
                    color: isSelected
                        ? AppColors.softPurpleNormalActive
                        : AppColors.softPurpleDarker,
                    size: 22.sp,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    fileName,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.softPurpleNormalActive
                          : const Color(0xFF333333),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.softPurpleNormalActive,
                    size: 22.sp,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildRoleDropdown() {
    if (controller.isRolesLoading.value) {
      return Skeletonizer(
        enabled: true,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFFE4DBFD)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Loading roles...',
                  style: getTextStyle(fontSize: 14.sp),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 24.sp),
            ],
          ),
        ),
      );
    }

    if (controller.targetRoles.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE4DBFD)),
        ),
        child: Text(
          'No roles found. Please add roles from your profile.',
          style: getTextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE4DBFD)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            'Choose a role',
            style: getTextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
          value: controller.selectedRole.value.isEmpty
              ? null
              : controller.selectedRole.value,
          icon: Icon(Icons.keyboard_arrow_down,
              color: AppColors.softPurpleDarker, size: 24.sp),
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
          items: controller.targetRoles.map((role) {
            return DropdownMenuItem<String>(
              value: role,
              child: Text(role),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.selectedRole.value = value;
            }
          },
        ),
      ),
    );
  }

  Widget buildInterviewCard({
    required int index,
    required String icon,
    required String title,
    required String subtitle,
  }) {
    bool isSelected = controller.selectedIndex.value == index;

    return InkWell(
      onTap: () => controller.selectType(index),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF6F3FF) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFFE4DBFD),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Image.asset(icon, height: 60.h),
            15.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.softPurpleNormalActive
                    : const Color(0xFF4A4A6A),
              ),
            ),
            15.verticalSpace,
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isSelected
                    ? AppColors.softPurpleNormalActive
                    : const Color(0xFF6B6B8A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
