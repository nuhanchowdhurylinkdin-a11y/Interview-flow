import 'package:dtc6464/features/auth/views/screens/otp_screen.dart';
import 'package:dtc6464/features/auth/views/screens/sign_in_screen.dart';
import 'package:dtc6464/features/interview_planner/views/screens/add_interview_screen.dart';
import 'package:dtc6464/features/interview_planner/views/screens/interview_planner_screen.dart';
import 'package:dtc6464/features/learning_roadmap/views/screens/learning_roadmap_screen.dart';
import 'package:dtc6464/features/nav_screens/profile/history/views/screens/history_screen.dart';
import 'package:dtc6464/features/nav_screens/profile/notifications/views/screens/notifications_screen.dart';
import 'package:dtc6464/features/nav_screens/profile/statistics/views/screens/statistics_screen.dart';
import 'package:dtc6464/features/nav_screens/profile/view_profile/views/screens/profile_screen.dart';
import 'package:dtc6464/features/onboarding/views/screens/avatar_selection_screen.dart';
import 'package:dtc6464/features/onboarding/views/screens/enter_name_screen.dart';
import 'package:dtc6464/features/pro_tips/views/screens/pro_tips_screen.dart';
import 'package:dtc6464/features/view_notifications/views/screens/view_notifications_screen.dart';
import 'package:get/get.dart';

import '../features/auth/views/screens/reset_password_screen.dart';
import '../features/auth/views/screens/sign_up_screen.dart';
import '../features/bottom_nav_bar/views/screens/bottom_nav_bar_screen.dart';
import '../features/collect_info/views/screens/ai_breaf.dart';
import '../features/collect_info/views/screens/collect_info_screen.dart';
import '../features/collect_info/views/screens/profile_analyzing.dart';
import '../features/onboarding/views/screens/onboarding_1.dart';
import '../features/onboarding/views/screens/onboarding_2.dart';
import '../features/splash/view/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen1 = "/onboardingScreen1";
  static String onboardingScreen2 = "/onboardingScreen2";
  static String collectInfoScreen = "/collectInfoScreen";
  static String profileAnalyzingScreen = "/profileAnalyzingScreen";
  static String aiBriefScreen = "/aiBriefScreen";
  static String signUpScreen = "/signUpScreen";
  static String signInScreen = "/signInScreen";
  static String verifyOtpScreen = "/verifyOtpScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String enterNameScreen = "/enterNameScreen";
  static String avatarSelectionScreen = "/avatarSelectionScreen";
  static String bottomNavBar = "/bottomNavBar";
  static String profileScreen = "/profileScreen";
  static String statisticsScreen = "/statisticsScreen";
  static String notificationsScreen = "/notificationsScreen";
  static String historyScreen = "/historyScreen";
  static String proTipsScreen = "/proTipsScreen";
  static String learningRoadmapScreen = "/learningRoadmapScreen";
  static String interviewPlannerScreen = "/interviewPlannerScreen";
  static String addInterviewScreen = "/addInterviewScreen";
  static String viewNotificationsScreen = "/viewNotificationsScreen";

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen1() => onboardingScreen1;
  static String getOnboardingScreen2() => onboardingScreen2;
  static String getCollectInfoScreen() => collectInfoScreen;
  static String getProfileAnalyzingScreen() => profileAnalyzingScreen;
  static String getAiBriefScreen() => aiBriefScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getSignInScreen() => signInScreen;
  static String getVerifyOtpScreen() => verifyOtpScreen;
  static String getResetPasswordScreen() => resetPasswordScreen;
  static String getEnterNameScreen() => enterNameScreen;
  static String getAvatarSelectionScreen() => avatarSelectionScreen;
  static String getBottomNavBar() => bottomNavBar;
  static String getProfileScreen() => profileScreen;
  static String getStatisticsScreen() => statisticsScreen;
  static String getNotificationsScreen() => notificationsScreen;
  static String getHistoryScreen() => historyScreen;
  static String getProTipsScreen() => proTipsScreen;
  static String getLearningRoadmapScreen() => learningRoadmapScreen;
  static String getInterviewPlannerScreen() => interviewPlannerScreen;
  static String getAddInterviewScreen() => addInterviewScreen;
  static String getViewNotificationsScreen() => viewNotificationsScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen1, page: () => Onboarding1()),
    GetPage(name: onboardingScreen2, page: () => Onboarding2()),
    GetPage(name: collectInfoScreen, page: () => CollectInfoScreen()),
    GetPage(name: profileAnalyzingScreen, page: () => ProfileAnalyzing()),
    GetPage(name: aiBriefScreen, page: () => AiBrief()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: signInScreen, page: () => SignInScreen()),
    GetPage(name: verifyOtpScreen, page: () => VerifyOtpScreen()),
    GetPage(name: resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(name: enterNameScreen, page: () => EnterNameScreen()),
    GetPage(name: avatarSelectionScreen, page: () => AvatarSelectionScreen()),
    GetPage(name: bottomNavBar, page: () => BottomNavBarScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: statisticsScreen, page: () => StatisticsScreen()),
    GetPage(name: notificationsScreen, page: () => NotificationsScreen()),
    GetPage(name: historyScreen, page: () => HistoryScreen()),
    GetPage(name: proTipsScreen, page: () => ProTipsScreen()),
    GetPage(name: learningRoadmapScreen, page: () => LearningRoadmapScreen()),
    GetPage(name: interviewPlannerScreen, page: () => InterviewPlannerScreen()),
    GetPage(name: addInterviewScreen, page: () => AddInterviewScreen()),
    GetPage(
      name: viewNotificationsScreen,
      page: () => ViewNotificationsScreen(),
    ),
  ];
}
