import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/snackbar_constant.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:dtc6464/features/auth/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/fcm_service.dart';
import '../../../core/utils/constants/api_constants.dart';
import '../../../routes/app_routes.dart';

class SignInController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();
  final FCMService _fcmService = Get.find<FCMService>();

  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // loading state
  RxBool isLoading = false.obs;

  // login data
  Rx<LoginModel?> loginData = Rx<LoginModel?>(null);

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // login
  Future<void> login() async {
    try {
      isLoading.value = true;
      await _fcmService.removeToken();
      final response = await _networkCaller.postRequest(
        ApiConstant.baseUrl + ApiConstant.login,
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );


      if (!response.isSuccess) {
        isLoading.value = false;
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
        return;
      }



      loginData.value = LoginModel.fromJson(response.responseData);

      // save token and user id
      await StorageService.saveTokens(
        accessToken: loginData.value!.data!.accessToken,
        refreshToken: loginData.value!.data!.refreshToken,
        userId: loginData.value!.data!.user.id,
      );

      AppLoggerHelper.debug(StorageService.accessToken.toString());
      final fcmToken = _fcmService.currentToken;
      if (fcmToken != null) {
        await _fcmService.registerToken(fcmToken);
      }
      isLoading.value = false;
      SnackBarConstant.success(title: 'Success', message: 'Login successful');
      final isFirstTimer = loginData.value?.data!.isFirstTimer ?? true;
      if(isFirstTimer) {
        Get.toNamed(AppRoute.getEnterNameScreen());
      } else {
        Get.toNamed(AppRoute.getBottomNavBar());
      }
    } catch (e) {
      AppLoggerHelper.error("Login Error: $e");
      SnackBarConstant.error(
        title: 'Failed',
        message: "An unexpected error occurred",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
