import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/controller/collect_info_controller.dart';
import 'package:dtc6464/features/collect_info/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';
import '../widgets/selection_chip.dart';

class Page3 extends StatelessWidget {
  Page3({super.key, required this.pageController, required this.controller});

  final CollectInfoController controller;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                text: 'Which company are you interviewing with?',
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
            ).paddingOnly(left: 26.w),
        
            20.verticalSpace,
        
            CustomTextField(
              controller: controller.interviewingCompanyController,
              hintText: "Search or add company",
              suffixIcon: IconButton(
                icon: Icon(Icons.add_circle_outline, color: AppColors.softPurpleDarker),
                onPressed: controller.addCompany,
              ),
            ),

            12.verticalSpace,

            Obx(
              () => Wrap(
                spacing: 5.w, // Gap between chips
                runSpacing: 15.h, // Gap between lines
                children: controller.filteredCompanies.map((company) {
                  final isSelected = controller.selectedCompanies.contains(
                    company,
                  );
                  return SelectionChip(
                    label: company,
                    isSelected: isSelected,
                    onTap: () => controller.toggleSelection(company),
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
