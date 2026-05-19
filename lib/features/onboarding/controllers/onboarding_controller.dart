import 'dart:async';

import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  RxDouble progressWidth = 0.0.obs;

  final double totalWidth = 240.w;
  final int durationInSeconds = 2;

  @override
  void onInit() {
    super.onInit();
    startProgress();
  }

  void startProgress() {
    double step = totalWidth / (durationInSeconds * 100);

    Timer.periodic(const Duration(milliseconds: 10), (timer) async {
      if (progressWidth.value >= totalWidth) {
        timer.cancel();
        await StorageService.saveIsFirstTimer();
        _navigateToNext();
      } else {
        progressWidth.value += step;
      }
    });
  }

  void _navigateToNext() {
    Get.offAllNamed(AppRoute.getOnboardingScreen2());
  }
}