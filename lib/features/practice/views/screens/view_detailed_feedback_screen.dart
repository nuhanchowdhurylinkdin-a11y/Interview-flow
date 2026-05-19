import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/practice/views/screens/select_interview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controller/practice_controller.dart';
import '../../model/analize_model.dart';

class ViewDetailedFeedbackScreen extends StatelessWidget {
  ViewDetailedFeedbackScreen({super.key});

  final PracticeController controller = Get.find<PracticeController>();

  @override
  Widget build(BuildContext context) {
    final feedbacks = controller.analizeData.value?.data.aiData.detailedFeedback ?? [];

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            'Detailed Feedback',
            style: getTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Image.asset(IconPath.bell, height: 30.h).paddingOnly(right: 15.w),
            ),
          ],
        ),
        body: feedbacks.isEmpty
            ? const Center(child: Text("No feedback available"))
            : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: feedbacks.map((item) => _buildFeedbackBlock(context, item)).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackBlock(BuildContext context, DetailedFeedback feedback) {
    return Column(
      children: [
        20.verticalSpace,

        // 1. Question Card
        _buildInfoCard(
          title: 'Question',
          icon: IconPath.question,
          content: feedback.question,
          titleColor: AppColors.softPurpleNormalHover,
        ),

        20.verticalSpace,

        // 2. Your Response Card
        _buildInfoCard(
          title: 'Your Response',
          icon: IconPath.strength,
          content: feedback.answer,
          titleColor: AppColors.softBlueNormal,
          iconBgColor: AppColors.softBlueActiveLight,
          iconColor: AppColors.softBlueNormalHover,
        ),

        20.verticalSpace,

        // 3. Clarity, Structure, Confidence Scores
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              ClarityCard(title: 'Clarity', data: feedback.overview.clarity),
              20.verticalSpace,
              ClarityCard(title: 'Structure', data: feedback.overview.structure),
              20.verticalSpace,
              ClarityCard(title: 'Confidence', data: feedback.overview.confidence),
            ],
          ),
        ),

        20.verticalSpace,

        // 4. Suggestions Card
        _buildSuggestionsCard(feedback.suggestions),

        20.verticalSpace,

        // 5. Sample Improved Answer (STAR Method)
        _buildSampleAnswerCard(feedback.sampleImprovedAnswer),

        40.verticalSpace,

        CustomFilledButton(
          text: 'Practice Next Question',
          onPressed: () {
            controller.nextQuestion();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ).paddingSymmetric(horizontal: 20.w),

        30.verticalSpace,
        const Divider(),
      ],
    );
  }

  // --- Helper UI Components ---

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF8A5CF6).withOpacity(0.20),
          blurRadius: 12,
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String icon,
    required String content,
    required Color titleColor,
    Color? iconBgColor,
    Color? iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 32.h, width: 32.w, padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: iconBgColor ?? Colors.transparent,
                ),
                child: Image.asset(icon, color: iconColor, height: 25.h),
              ),
              12.horizontalSpace,
              Text(title, style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: titleColor)),
            ],
          ),
          10.verticalSpace,
          Text(content, style: getTextStyle(fontSize: 14.sp, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSuggestionsCard(List<String> suggestions) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFFCBA9)),
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFDDC8).withOpacity(0.5), const Color(0xFFFFECC3).withOpacity(0.5)],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(IconPath.bulb, color: const Color(0xFFF97316), height: 24.h),
              12.horizontalSpace,
              Text('Suggestions', style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4B5563))),
            ],
          ),
          15.verticalSpace,
          ...suggestions.asMap().entries.map((entry) => Padding(
            padding: EdgeInsets.only(left: 10.w, bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${entry.key + 1}. ', style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                Expanded(child: Text(entry.value, style: getTextStyle(fontSize: 14.sp, color: const Color(0xFF4B5563)))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSampleAnswerCard(SampleImprovedAnswer sample) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFE6DFFF), Color(0xFFF0EBFF)]),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(IconPath.ai2, color: const Color(0xFFA896E6), height: 24.h),
              12.horizontalSpace,
              Text('Sample Improved Answer', style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            ],
          ),
          20.verticalSpace,
          _starSection('Situation', sample.situation),
          _starSection('Task', sample.task),
          _starSection('Action', sample.action),
          _starSection('Result', sample.result),
        ],
      ),
    );
  }

  Widget _starSection(String label, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 35.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF4A4A6A))),
          Text(content, style: getTextStyle(fontSize: 14.sp, color: const Color(0xFF6B6B8A))),
        ],
      ),
    );
  }
}

class ClarityCard extends StatelessWidget {
  final String title;
  final Clarity data;
  const ClarityCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    int rating = int.tryParse(data.rating.split('/').first) ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 3.5, backgroundColor: Color(0xFF22262D)),
                8.horizontalSpace,
                Text(title, style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
              ],
            ),
            Row(
              children: [
                for (int i = 1; i <= 5; i++)
                  Container(
                    height: 7.h, width: 7.w, margin: EdgeInsets.only(right: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color: i <= rating ? const Color(0xFF367588) : const Color(0xFFC7CACF),
                    ),
                  ),
                Text(data.rating, style: getTextStyle(fontSize: 14.sp, color: const Color(0xFF367588))),
              ],
            )
          ],
        ),
        8.verticalSpace,
        Text(data.explanation, style: getTextStyle(fontSize: 14.sp, color: const Color(0xFF4B5563))),
      ],
    );
  }
}
