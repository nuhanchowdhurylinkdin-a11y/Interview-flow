import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/nav_screens/profile/statistics/controllers/statistics_controller.dart';
import 'package:dtc6464/features/nav_screens/profile/statistics/widgets/progress_bar_item.dart';
import 'package:dtc6464/features/nav_screens/profile/statistics/widgets/statistics_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.put if it's not already initialized elsewhere
    final controller = Get.put(StatisticsController());

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Statistics',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                28.verticalSpace,
                Obx(() {
                  final isLoading = controller.isStatisticsLoading.value;
                  final data = controller.statsData;

                  return Skeletonizer(
                    enabled: isLoading,
                    child: StatisticsCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Progress',
                            style: TextStyle(
                              color: const Color(0xFF4A4A6A),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                          20.verticalSpace,

                          // Overall Progress
                          ProgressBarItem(
                            label: 'Overall Progress',
                            value: '${data?.overallProgress ?? 0}%',
                            progress: (data?.overallProgress ?? 0) / 100,
                          ),

                          20.verticalSpace,

                          // Sessions Completed
                          _buildStatRow(
                            label: 'Practice Sessions Completed',
                            value: '${data?.practiceSessionsCount ?? 0}',
                          ),

                          20.verticalSpace,

                          // Average Score
                          _buildStatRow(
                            label: 'Average Score',
                            value: '${data?.avarageScore?.toStringAsFixed(1) ?? "0.0"}%',
                          ),

                          20.verticalSpace,
                          Center(
                            child: Text(
                              'Keep improving with regular practice',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF2A8EBA),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.75,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                80.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to keep the code clean
  Widget _buildStatRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF333333),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: 1.75,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: const Color(0xFF967DE1),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: 1.75,
          ),
        ),
      ],
    );
  }
}