import 'package:dtc6464/features/auth/controller/reset_password_controller.dart';
import 'package:dtc6464/features/auth/controller/sign_in_controller.dart';
import 'package:dtc6464/features/auth/controller/sign_up_controller.dart';
import 'package:dtc6464/features/collect_info/controller/collect_info_controller.dart';
import 'package:dtc6464/features/home/controller/home_screen_controller.dart';
import 'package:dtc6464/features/nav_screens/profile/statistics/controllers/statistics_controller.dart';
import 'package:dtc6464/features/onboarding/controllers/onboarding_controller.dart';
import 'package:dtc6464/features/practice/controller/practice_controller.dart';
import 'package:get/get.dart';

import '../services/fcm_service.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
      // fenix: true,
    );

    Get.lazyPut(()=>FCMService());



    Get.lazyPut<CollectInfoController>(
      () => CollectInfoController(),
      // fenix: true,
    );

    Get.lazyPut<SignInController>(() => SignInController(), fenix: true);

    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);

    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
      fenix: true,
    );

    Get.lazyPut<HomeScreenController>(
      () => HomeScreenController(),
      fenix: true,
    );

    Get.lazyPut<PracticeController>(
          () => PracticeController(),
      fenix: true,
    );

    Get.lazyPut<StatisticsController>(
          () => StatisticsController(),
      fenix: true,
    );
  }
}
