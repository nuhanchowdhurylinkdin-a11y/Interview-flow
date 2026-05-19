import 'package:dtc6464/features/learning_roadmap/controllers/learning_roadmap_controller.dart';
import 'package:dtc6464/features/learning_roadmap/widgets/week_card.dart';
import 'package:dtc6464/features/learning_roadmap/widgets/your_progress_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../model/roadmap_model.dart';

class LearningRoadmapScreen extends StatelessWidget {
  const LearningRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearningRoadmapController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          'Learning Roadmap',
          style: getTextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Obx(() {
        final bool isLoading = controller.isRoadMapLoading.value;
        final bool isError = controller.isRoadMapError.value;
        final bool hasNoData = controller.roadmap.value == null;

        if (isError && hasNoData) {
          return _buildErrorWidget(controller);
        }

        final List<LearningArea> displayList = isLoading || hasNoData
            ? List.generate(5, (index) => controller.getPlaceholderArea())
            : controller.roadmap.value!.data.learningAreas;

        return Skeletonizer(
          enabled: isLoading,
          child: RefreshIndicator(
            onRefresh: () => controller.getRoadMap(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YourProgressSection(),
                  24.verticalSpace,
                  Text(
                    'Interview Prep Plan',
                    style: getTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  14.verticalSpace,
                  Column(
                    children: displayList.map((item) => Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: WeekCard(item: item),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildErrorWidget(LearningRoadmapController controller) {
    return Center(
      child: InkWell(
        onTap: () => controller.getRoadMap(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.refresh, color: Colors.grey, size: 40),
            10.verticalSpace,
            const Text('Failed to load roadmap. Tap to retry.'),
          ],
        ),
      ),
    );
  }
}
