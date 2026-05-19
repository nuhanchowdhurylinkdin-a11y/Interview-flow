import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/features/nav_screens/profile/history/model/planner_history_model.dart' as planner_model;
import 'package:dtc6464/features/nav_screens/profile/history/model/practice_sessions_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/services/storage_service.dart';
import '../../../../../core/utils/constants/snackbar_constant.dart';
import '../views/screens/view_feedback_screen.dart';

class PracticeSession {
  final String title;
  final String dateTime;
  final String scoreOrStatus;
  final bool isScore;

  PracticeSession({
    required this.title,
    required this.dateTime,
    required this.scoreOrStatus,
    required this.isScore,
  });
}

class PlannerItem {
  final String title;
  final String dateAndRound;
  final String status;

  PlannerItem({
    required this.title,
    required this.dateAndRound,
    required this.status,
  });
}

class HistoryController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  @override
  void onInit() {
    super.onInit();
    getPractice();
    getPlannerHistory(); // Fetch planner data on init
  }

  final activeTab = 0.obs;
  final isPracticeLoading = false.obs;
  final isPlannerLoading = false.obs;
  final isPracticeError = false.obs;
  final isPlannerError = false.obs;

  final Rx<PracticeSessionsModel?> practiceHistory = Rx<PracticeSessionsModel?>(null);
  final Rx<planner_model.PlannerHistoryModel?> plannerHistory = Rx<planner_model.PlannerHistoryModel?>(null);

  final RxList<PracticeSession> dynamicPracticeList = <PracticeSession>[].obs;
  final RxList<PlannerItem> dynamicPlannerList = <PlannerItem>[].obs;

  /// Fetches Practice Sessions
  Future<void> getPractice() async {
    try {
      isPracticeLoading.value = true;
      isPracticeError.value = false;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.practiceSessions,
        token: StorageService.accessToken,
      );

      if (!response.isSuccess) {
        isPracticeError.value = true;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }

      final model = PracticeSessionsModel.fromJson(response.responseData);
      practiceHistory.value = model;

      dynamicPracticeList.value = model.data.map((datum) {
        String typeLabel = typeValues.reverse[datum.type]?.capitalizeFirst ?? "General";
        String formattedDate = DateFormat('dd/MM/yyyy').format(datum.updatedAt);
        bool hasScore = datum.overallScore != null;

        return PracticeSession(
          title: "$typeLabel Interview",
          dateTime: formattedDate,
          scoreOrStatus: hasScore ? "Score: ${datum.overallScore}%" : "In Progress",
          isScore: hasScore,
        );
      }).toList();
    } finally {
      isPracticeLoading.value = false;
    }
  }

  /// Fetches Planner History from API
  Future<void> getPlannerHistory() async {
    try {
      isPlannerLoading.value = true;
      isPlannerError.value = false;

      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.plannerHistory, // '/history/planner'
        token: StorageService.accessToken,
      );

      if (!response.isSuccess) {
        isPlannerError.value = true;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }

      final model = planner_model.PlannerHistoryModel.fromJson(response.responseData);
      plannerHistory.value = model;

      // Map API data to PlannerItem UI model
      dynamicPlannerList.value = model.data.map((datum) {
        String formattedDate = DateFormat('MMM dd, yyyy').format(datum.interviewDate);

        return PlannerItem(
          title: datum.companyName,
          dateAndRound: '$formattedDate · ${datum.interviewPhase}',
          status: datum.status.capitalizeFirst ?? "Scheduled",
        );
      }).toList();

    } catch (e) {
      isPlannerError.value = true;
    } finally {
      isPlannerLoading.value = false;
    }
  }

  void switchTab(int index) => activeTab.value = index;

  List<PracticeSession> getPracticePlaceholder() {
    return List.generate(4, (index) => PracticeSession(
      title: "Loading Interview...",
      dateTime: "Date Loading...",
      scoreOrStatus: "Score: 0%",
      isScore: true,
    ));
  }

  List<PlannerItem> getPlannerPlaceholder() {
    return List.generate(4, (index) => PlannerItem(
      title: "Company Name",
      dateAndRound: "Date · Round",
      status: "Scheduled",
    ));
  }

  void viewDetailedFeedback(Datum sessionData, BuildContext context) {
    AppHelperFunctions.navigateToScreen(context, ViewFeedbackScreen(session: sessionData));
  }
}