import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../controllers/interview_planner_controller.dart';
import '../../widgets/add_interview_action_buttons.dart';
import '../../widgets/add_interview_date_time_section.dart';
import '../../widgets/add_interview_form_field.dart';
import '../../widgets/add_interview_phase_dropdown.dart';
import '../../widgets/add_interview_reminders_section.dart';

class AddInterviewScreen extends StatefulWidget {
  const AddInterviewScreen({super.key});

  @override
  State<AddInterviewScreen> createState() => _AddInterviewScreenState();
}

class _AddInterviewScreenState extends State<AddInterviewScreen> {
  late final controller = Get.find<InterviewPlannerController>();

  @override
  void initState() {
    super.initState();
    controller.clearForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'Add Interview',
          style: getTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24.h,
            children: [
              // Company Name
              AddInterviewFormField(
                label: 'Company Name',
                hintText: 'Enter company name',
                controller: controller.companyNameController,
              ),

              // Role
              AddInterviewFormField(
                label: 'Role',
                hintText: 'Enter job title',
                controller: controller.roleController,
              ),

              // Job Description
              AddInterviewFormField(
                label: 'Paste Job Description',
                hintText: 'Paste the job description here',
                controller: controller.jobDescriptionController,
                maxLines: 4,
              ),

              // Date and Time pickers
              AddInterviewDateTimeSection(controller: controller),

              // Interview Phase Dropdown
              AddInterviewPhaseDropdown(controller: controller),

              // Notes
              AddInterviewFormField(
                label: 'Notes (Optional)',
                hintText: 'Add any notes about this interview',
                controller: controller.noteController,
                maxLines: 3,
              ),

              // Reminders
              AddInterviewRemindersSection(controller: controller),

              SizedBox(height: 12.h),

              // Action buttons
              Obx(() {
                if(controller.isAddInterviewLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.softPurpleNormal,
                      strokeWidth: 3,
                    ),
                  );
                }
                return AddInterviewActionButtons(
                  controller: controller,
                  onAddToCalendar: () {
                    Get.snackbar('Success', 'Added to calendar');
                  },
                  onSaveInterview: () {
                    // Save interview
                    if (controller.companyNameController.text.isEmpty ||
                        controller.roleController.text.isEmpty ||
                        controller.selectedDate.value == null ||
                        controller.selectedTime.value == null) {
                      Get.snackbar('Error', 'Please fill all required fields');
                      return;
                    }

                    controller.addInterview();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
