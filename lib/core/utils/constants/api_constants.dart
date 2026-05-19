class ApiConstant {
  ApiConstant._();

  // base url
  static const String baseUrl = 'https://api.datatechcon.com/api/v1';
  // static const String baseUrl = "https://dtc4646-server.onrender.com/api/v1";
  static const String imgBaseUrl = 'https://dtc4646-server.onrender.com';

  // analyze
  static const String analyze = '/public/analyze';

  // authentication
  static const String token = '/auth/refresh';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-email';
  static const String forgotPassword = '/auth/password-reset/send-code';

  // avatar
  static const String avatar = '/user/all-profile-pictures';

  // user
  static const String profileUpdate = '/user/profile-update';
  static const String progress = '/user/your-progress';
  static const String profile = '/user/profile';

  // tips
  static const String todayTips = '/tips/daily-tips';
  static const String proTips = '/tips/pro-tips';

  // interview
  static const String addInterview = '/interview/plan';
  static const String interviewsPlans = '/interview/plans';

  // roadmap
  static const String roadMap = "/roadmap";

  // interview
  static const String startInterview = '/practice/start';
  static const String submitInterview = '/practice/submit-answers/';
  static const String resumeInterview = '/practice/resume-status';
  static const String recentActivity = '/practice/recent-activity';
  static const String resumedQuestions = '/practice/resume-questions/';


  // history
  static const String practiceSessions = '/history/practice-sessions';
  static const String plannerHistory = '/history/planner';
  static const String statistics = '/history/statistics';

  // resume
  static const String resume = '/user/resume';
  static const String resumes = '/user/resumes';

  // target roles
  static const String targetRole = '/user/target-role';

  // notification
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notification-settings';
  static const String registerFcmToken = '/user/fcm-token';
  static const String removeFcmToken = '/user/fcm-token';
  static const String markAsRead = '/notifications/mark-read/';
  static const String markAllAsRead = '/notifications/mark-all-read/';

}