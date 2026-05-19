import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../controllers/interview_planner_controller.dart';
import '../../model/interviews_model.dart' show Datum;
import '../../widgets/interview_card.dart';

class InterviewPlannerScreen extends StatelessWidget {
  InterviewPlannerScreen({super.key});
  final controller = Get.put(InterviewPlannerController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getInterviews(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 70.h,
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Interview Planner',
                  style: getTextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed('/addInterviewScreen'),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EFFF),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.w,
                    children: [
                      Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, 0.50),
                            end: Alignment(1.00, 0.50),
                            colors: [Color(0xFFA78BFA), Color(0xFF7C3AED)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, size: 16.w, color: Colors.white),
                      ),
                      Text(
                        'Add',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7C3AED),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Obx(() {
            final bool isLoading = controller.isInterviewPlansLoading.value;
            final bool isError = controller.isInterviewPlansError.value;
            final bool isEmpty =
                controller.interviews.value == null ||
                controller.interviews.value!.data.isEmpty;

            if (isLoading) {
              final List<Datum> displayList = List.generate(
                4,
                (index) => controller.getPlaceholderInterview(),
              );
              return _buildSkeletonList(displayList, true);
            }

            if (isError) {
              return _buildErrorWidget();
            }

            if (isEmpty) {
              return _buildEmptyWidget();
            }

            return _buildSkeletonList(controller.interviews.value!.data, false);
          }),
        ),
      ),
    );
  }

  Widget _buildSkeletonList(List<Datum> list, bool enabled) {
    return Skeletonizer(
      enabled: enabled,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          spacing: 12.h,
          children: list.map((data) => InterviewCard(interview: data)).toList(),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: InkWell(
        onTap: () => controller.getInterviews(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.refresh, size: 40.sp, color: Colors.grey),
            10.verticalSpace,
            Text(
              'Failed to load interviews. Tap to retry.',
              style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 80.w,
            color: const Color(0xFFE4DBFD),
          ),
          20.verticalSpace,
          Text(
            'No interviews scheduled',
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6D6E6F),
            ),
          ),
        ],
      ),
    );
  }
}
