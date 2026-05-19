import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/custom_filled_button.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/helpers/app_helper.dart';
import '../../../background/views/widgets/background.dart';
import '../../controller/practice_controller.dart';
import 'practice_summary.dart';
import 'select_interview.dart';

class AiCoachMode extends StatelessWidget {
  AiCoachMode({super.key});

  final PracticeController controller = Get.find<PracticeController>();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'AI Coach Mode',
            style: getTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: const Color(0xFF333333)),
          ),
        ),
        body: Obx(() {
          final bool isLoading = controller.isStartPracticeLoading.value;
          final questionsData = controller.questions.value?.data.aiData.personalizedQuestions;

          final currentQuestion = (questionsData != null && questionsData.isNotEmpty)
              ? questionsData[controller.selectedQuestion.value]
              : controller.getPlaceholderQuestion();

          return Skeletonizer(
            enabled: isLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    20.verticalSpace,

                    // Question Card
                    _buildQuestionCard(context, currentQuestion),

                    25.verticalSpace,

                    // Input Selection (Voice or Type)
                    Obx(() {
                      if (controller.inputType.value == 'type') {
                        return _buildTypeInput();
                      } else {
                        return VoiceNote(controller: controller);
                      }
                    }),

                    // --- Action Buttons with Proper Gaps ---
                    Obx(() {
                      bool hasContent = controller.recognizedText.value.isNotEmpty || controller.inputType.value == 'type';
                      if (!hasContent) return const SizedBox.shrink();

                      return Column(
                        children: [
                          20.verticalSpace,
                          CustomFilledButton(
                            text: 'Submit Answer',
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFDDC8), Color(0xFFFFECC3)],
                            ),
                            textColor: const Color(0xFFF97316),
                            onPressed: () {
                              controller.submitInterview(context);
                              AppHelperFunctions.navigateToScreen(context, PracticeSummary());
                            },
                          ).paddingSymmetric(horizontal: 35.w),
                        ],
                      );
                    }),

                    20.verticalSpace, // Gap between Submit and End Practice

                    CustomFilledButton(
                      text: 'End Practice',
                      onPressed: () {
                        controller.resetData();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SelectInterview()),
                              (route) => false,
                        );
                      },
                    ).paddingSymmetric(horizontal: 35.w),

                    20.verticalSpace,

                    _buildToggleModeButton(),

                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, dynamic currentQuestion) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: const Color(0xFF8A5CF6).withOpacity(0.20), blurRadius: 12)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(IconPath.question, height: 25.h),
              12.horizontalSpace,
              Text('Interview Question', style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.softBlueNormal)),
            ],
          ),
          10.verticalSpace,
          Text(currentQuestion.question, style: getTextStyle(fontSize: 14.sp, color: AppColors.softPurpleDark)),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _actionBtn(IconPath.microphone, 'Play Audio', const Color(0xFFE4DBFD), const Color(0xFF866FC8), () => controller.speak(currentQuestion.question)),
              10.horizontalSpace,
              _actionBtn(IconPath.bulb, 'Details', const Color(0xFFFFEDE2), const Color(0xFFF97316), () => _showHints(context, currentQuestion.hints)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(String icon, String label, Color bg, Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: bg),
        child: Row(
          children: [
            Image.asset(icon, height: 18.h, color: iconColor),
            5.horizontalSpace,
            Text(label, style: getTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: const Color(0xFF8A5CF6).withOpacity(0.2), blurRadius: 12)],
      ),
      child: TextField(
        controller: controller.answerController, // Use the shared controller
        maxLines: 7,
        minLines: 5,
        onChanged: (value) {
          controller.recognizedText.value = value;
          controller.updateCompleteSentence(value);
        },
        style: getTextStyle(fontSize: 15.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: "Type your answer here...",
          contentPadding: EdgeInsets.all(16.w),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildToggleModeButton() {
    return TextButton(
      onPressed: () => controller.inputType.value = (controller.inputType.value == "voice" ? "type" : "voice"),
      child: Text(
        controller.inputType.value == "voice" ? 'Prefer typing instead?' : 'Prefer voice instead?',
        style: getTextStyle(fontSize: 14.sp, color: AppColors.softPurpleNormalActive),
      ),
    );
  }

  void _showHints(BuildContext context, List<String> hints) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: hints.map((h) => ListTile(leading: const Icon(Icons.check, color: Colors.green), title: Text(h))).toList(),
        ),
      ),
    );
  }
}

class VoiceNote extends StatelessWidget {
  const VoiceNote({super.key, required this.controller});
  final PracticeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hold the microphone and start answering',
          style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.softPurpleDark),
        ),
        20.verticalSpace,

        // --- Editable Live Text Preview Area ---
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE4DBFD)),
            boxShadow: [
              BoxShadow(color: const Color(0xFF8A5CF6).withOpacity(0.05), blurRadius: 10)
            ],
          ),
          child: TextField(
            controller: controller.answerController,
            maxLines: 8,
            minLines: 4,
            onChanged: (value) {
              controller.recognizedText.value = value;
              controller.updateCompleteSentence(value);
            },
            style: getTextStyle(fontSize: 15.sp, color: Colors.black87),
            decoration: InputDecoration(
              hintText: "Your speech will appear here... you can edit it anytime.",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
              contentPadding: EdgeInsets.all(15.w),
              border: InputBorder.none,
            ),
          ),
        ),

        20.verticalSpace,

        // Mic Button with Ripple
        Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            if (controller.isRecording.value)
              _buildRippleEffect(),
            GestureDetector(
              onLongPress: () => controller.startListening(),
              onLongPressUp: () => controller.stopListening(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: controller.isRecording.value ? 110.h : 100.h,
                width: controller.isRecording.value ? 110.h : 100.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Color(0xFFA78BFA), Color(0xFF5835C0)]),
                ),
                child: Icon(
                  controller.isRecording.value ? Icons.stop : Icons.mic,
                  color: Colors.white,
                  size: 40.sp,
                ),
              ),
            ),
          ],
        )),
        10.verticalSpace,
        Obx(() => Text(
          controller.isRecording.value ? "Listening... Speak now" : "Hold to talk or tap text to edit",
          style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
        )),
      ],
    );
  }

  Widget _buildRippleEffect() {
    return Container(
      height: 140.h,
      width: 140.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF8A5CF6).withOpacity(0.2),
      ),
    );
  }
}