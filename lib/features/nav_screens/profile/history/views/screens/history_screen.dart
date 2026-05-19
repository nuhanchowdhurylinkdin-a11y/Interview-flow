import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/nav_screens/profile/history/controllers/history_controller.dart';
import 'package:dtc6464/features/nav_screens/profile/history/widgets/empty_state_widget.dart';
import 'package:dtc6464/features/nav_screens/profile/history/widgets/history_tab_button.dart';
import 'package:dtc6464/features/nav_screens/profile/history/widgets/planner_card.dart';
import 'package:dtc6464/features/nav_screens/profile/history/widgets/practice_session_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    return Background(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.getPractice();
          controller.getPlannerHistory();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'History',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  28.verticalSpace,
                  // Tab Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Expanded(
                          child: Obx(
                            () => HistoryTabButton(
                              label: 'practice Sessions',
                              isActive: controller.activeTab.value == 0,
                              onPressed: () => controller.switchTab(0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => HistoryTabButton(
                              label: 'Planner',
                              isActive: controller.activeTab.value == 1,
                              onPressed: () => controller.switchTab(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  // Tab Content
                  Obx(() {
                    if (controller.activeTab.value == 0) {
                      final bool isLoading = controller.isPracticeLoading.value;
                      final sessions = isLoading
                          ? controller.getPracticePlaceholder()
                          : controller.dynamicPracticeList;

                      if (!isLoading && sessions.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Practice Session yet',
                          subtitle: 'Complete a practice session to see it here',
                        );
                      }

                      return Skeletonizer(
                      enabled: isLoading,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            ...sessions.asMap().entries.map((entry) {
                              int index = entry.key;
                              var sessionDisplay = entry.value;

                              return Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: PracticeSessionCard(
                                  title: sessionDisplay.title,
                                  dateTime: sessionDisplay.dateTime,
                                  scoreOrStatus: sessionDisplay.scoreOrStatus,
                                  isScore: sessionDisplay.isScore,
                                  onViewFeedback: () {
                                    if (!isLoading) {
                                      final rawData = controller.practiceHistory.value!.data[index];
                                      controller.viewDetailedFeedback(rawData , context);
                                    }
                                  },
                                ),
                              );
                            }),
                            80.verticalSpace,
                          ],
                        ),
                      ),
                      );
                    } else {
                      final bool isLoading = controller.isPlannerLoading.value;
                      final plannerItems = isLoading
                          ? controller.getPlannerPlaceholder()
                          : controller.dynamicPlannerList;

                      if (!isLoading && plannerItems.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Planner History',
                          subtitle: 'Your scheduled interviews will appear here',
                        );
                      }

                      return Skeletonizer(
                        enabled: isLoading,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              ...plannerItems.map(
                                    (item) => Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: PlannerCard(
                                    title: item.title,
                                    dateAndRound: item.dateAndRound,
                                    status: item.status,
                                  ),
                                ),
                              ),
                              80.verticalSpace,
                            ],
                          ),
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
