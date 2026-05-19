import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/features/auth/views/screens/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/api_constants.dart';
import '../../../core/utils/constants/snackbar_constant.dart';

class ForgotPasswordController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  final TextEditingController emailController = TextEditingController();
  String otp = "";

  RxBool isForgotPasswordLoading = false.obs;

  Future<void> forgotPassword() async {
    try {
      isForgotPasswordLoading.value = true;
      final response = await _networkCaller.postRequest(
        ApiConstant.baseUrl + ApiConstant.forgotPassword,
        body: {
          "email": emailController.text.trim(),
        }
      );

      if(!response.isSuccess) {
        isForgotPasswordLoading.value = false;
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
        return;
      }

      isForgotPasswordLoading.value = false;
      SnackBarConstant.success(title: 'Success', message: 'OTP sent to your email.');
    } catch (e) {
      isForgotPasswordLoading.value = false;
      SnackBarConstant.error(title: 'Error', message: e.toString());
    } finally {
      isForgotPasswordLoading.value = false;
    }
  }
}