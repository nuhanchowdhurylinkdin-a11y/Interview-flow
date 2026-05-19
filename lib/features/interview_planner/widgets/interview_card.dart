import 'package:dtc6464/features/interview_planner/model/interviews_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../controllers/interview_planner_controller.dart';
import './interview_card_action_buttons.dart';
import './interview_card_header.dart';
import './interview_card_info_section.dart';
import './interview_card_progress_section.dart';

class InterviewCard extends StatelessWidget {
  final Datum interview;

  InterviewCard({super.key, required this.interview});
  final controller = Get.find<InterviewPlannerController>();
  @override
  Widget build(BuildContext context) {

    final initials = controller.getAvatarInitials(interview.companyName);
    final statusBgColor = Color(
      int.parse(controller.getStatusColor(interview.status)),
    );
    final statusTextColor = Color(
      int.parse(controller.getStatusTextColor(interview.status)),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE4DBFD).withValues(alpha: 0.6),
            blurRadius: 10,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 30.h,
        children: [
          // Header with avatar, company info, and status
          InterviewCardHeader(
            companyName: interview.companyName,
            role: interview.jobTitle,
            initials: initials,
            status: interview.status,
            statusBgColor: statusBgColor,
            statusTextColor: statusTextColor,
          ),
          // Date, Round, Reminder info
          InterviewCardInfoSection(
            interviewDate: interview.interviewDate,
            round: interview.interviewPhase,
            reminderBeforeOneDay: interview.oneDayBeforeReminder,
            reminderBeforeOneHour: interview.oneHourBeforeReminder,
          ),
          // Progress section
          InterviewCardProgressSection(preparationProgress: interview.preparationProgress / 100),
          // Action buttons
          InterviewCardActionButtons(
            onChangeStatus: () {
              Get.bottomSheet(
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Select Status', style: getTextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                      20.verticalSpace,
                      _statusOption('SCHEDULED', Icons.timer, Colors.blue, interview.id),
                      _statusOption('COMPLETED', Icons.check_circle, Colors.green, interview.id),
                      _statusOption('CANCELLED', Icons.cancel, Colors.red, interview.id),
                    ],
                  ),
                ),
              );
            },
            onStartPractice: () {},
          ),
        ],
      ),
    );
  }

  Widget _statusOption(String status, IconData icon, Color color, String id) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(status),
      onTap: () {
        controller.changeStatus(status, id);
        Get.back();
      },
    );
  }
}
