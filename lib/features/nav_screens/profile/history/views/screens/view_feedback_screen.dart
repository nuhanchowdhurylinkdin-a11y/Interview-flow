import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/nav_screens/profile/history/model/practice_sessions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewFeedbackScreen extends StatelessWidget {
  final Datum session;

  const ViewFeedbackScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Feedback Analysis',
            style: TextStyle(
              color: const Color(0xFF3A3158),
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // --- Overall Score Card ---
              _buildOverallScoreCard(),
              24.verticalSpace,

              // --- Individual Question Feedbacks ---
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: session.questions.length,
                itemBuilder: (context, index) {
                  final question = session.questions[index];
                  return _buildQuestionFeedbackTile(question, index + 1);
                },
              ),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallScoreCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFA78BFA), Color(0xFF5835C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5835C0).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overall Score",
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14.sp),
              ),
              8.verticalSpace,
              Text(
                "${session.overallScore ?? 0}%",
                style: TextStyle(color: Colors.white, fontSize: 32.sp, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Icon(Icons.auto_awesome, color: Colors.white.withOpacity(0.5), size: 40.w),
        ],
      ),
    );
  }

  Widget _buildQuestionFeedbackTile(Question q, int index) {
    if (q.feedback == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F0FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Q$index",
                  style: TextStyle(color: const Color(0xFF5835C0), fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Text(
                  q.question,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF3A3158)),
                ),
              ),
            ],
          ),
          20.verticalSpace,
          const Divider(),

          // --- User's Answer ---
          _sectionHeader("Your Answer"),
          Text(
            q.answer ?? "N/A",
            style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700, height: 1.5),
          ),
          20.verticalSpace,

          // --- AI Metrics Overview ---
          _sectionHeader("AI Performance Ratings"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _metricChip("Clarity", q.feedback!.overview.clarity.rating),
              _metricChip("Structure", q.feedback!.overview.structure.rating),
              _metricChip("Confidence", q.feedback!.overview.confidence.rating),
            ],
          ),
          20.verticalSpace,

          // --- Suggestions ---
          _sectionHeader("How to Improve?"),
          ...q.feedback!.suggestions.map((s) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, size: 16.w, color: Colors.orange),
                8.horizontalSpace,
                Expanded(child: Text(s, style: TextStyle(fontSize: 13.sp, color: Colors.black87))),
              ],
            ),
          )),
          20.verticalSpace,

          // --- STAR Sample Answer ---
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFEEF2F6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader("Sample STAR Answer"),
                _starRow("S", "Situation", q.feedback!.sampleImprovedAnswer.situation),
                _starRow("T", "Task", q.feedback!.sampleImprovedAnswer.task),
                _starRow("A", "Action", q.feedback!.sampleImprovedAnswer.action),
                _starRow("R", "Result", q.feedback!.sampleImprovedAnswer.result),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFFA1A1A1), letterSpacing: 1),
      ),
    );
  }

  Widget _metricChip(String label, Rating rating) {
    String ratingText = ratingValues.reverse[rating] ?? "0/5";
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
        4.verticalSpace,
        Text(ratingText, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF5835C0))),
      ],
    );
  }

  Widget _starRow(String letter, String label, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label ($letter):", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2A8EBA))),
          4.verticalSpace,
          Text(content, style: TextStyle(fontSize: 12.sp, color: Colors.black87, height: 1.4)),
        ],
      ),
    );
  }
}