import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/constants/snackbar_constant.dart';
import 'package:dtc6464/core/utils/helpers/app_helper.dart';
import 'package:dtc6464/features/auth/model/sign_up_model.dart';
import 'package:dtc6464/features/auth/views/screens/otp_screen.dart';
import 'package:dtc6464/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/network_caller.dart';

class SignUpController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String otp = "";
  RxBool isOtpLoading = false.obs;
  Rx<SignUpModel?> signUpData = Rx<SignUpModel?>(null);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  RxBool isSignUpLoading = false.obs;
  RxBool isSignUpError = false.obs;
  RxBool isTermsAccepted = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  void toggleTermsAccepted(bool? value) => isTermsAccepted.value = value ?? false;

  bool _isValid() {
    if (!isTermsAccepted.value) {
      SnackBarConstant.error(title: 'Required', message: 'You must agree to the Terms & Conditions and Privacy Policy');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      SnackBarConstant.error(title: 'Invalid Input', message: 'Email is required');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      SnackBarConstant.error(title: 'Invalid Input', message: 'Enter a valid email address');
      return false;
    }
    if (passwordController.text.isEmpty) {
      SnackBarConstant.error(title: 'Invalid Input', message: 'Password is required');
      return false;
    }
    if (passwordController.text.length < 6) {
      SnackBarConstant.error(title: 'Invalid Input', message: 'Password must be at least 6 characters');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      SnackBarConstant.error(title: 'Invalid Input', message: 'Passwords do not match');
      return false;
    }
    return true;
  }

  Future<void> signUp(BuildContext context) async {
    // Validate before making API call
    if (!_isValid()) return;

    try {
      isSignUpLoading.value = true;
      isSignUpError.value = false;

      final userProfileId = StorageService.userProfileId;
      final response = await _networkCaller.postRequest(
          ApiConstant.baseUrl + ApiConstant.register,
          body: {
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
            "profileId": userProfileId
          }
      );

      if (!response.isSuccess) {
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
        return;
      }

      signUpData.value = SignUpModel.fromJson(response.responseData);
      isSignUpLoading.value = false;
      isSignUpError.value = false;
      // Success logic here (e.g., navigate to login)
      SnackBarConstant.success(title: 'Success', message: 'Account created successfully');

      AppHelperFunctions.navigateToScreen(context, VerifyOtpScreen(isFromSignUp: true,));
    } catch (e) {
      isSignUpError.value = true;
      SnackBarConstant.error(title: 'Error', message: e.toString());
    } finally {
      isSignUpLoading.value = false;
    }
  }

  Future<void> verifyOtp(bool isFromSignUpScreen) async {
    if (otp.isEmpty) {
      SnackBarConstant.warning(title: 'Failed', message: 'Please enter the OTP');
      return;
    }

    try {
      isOtpLoading.value = true;
      final response = await _networkCaller.postRequest(
        ApiConstant.baseUrl + ApiConstant.verifyOtp,
        body: {
          "email": emailController.text.trim(),
          "code": otp,
        }
      );

      if(!response.isSuccess) {
        isOtpLoading.value = false;
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
        return;
      }

      isOtpLoading.value = false;
      SnackBarConstant.success(title: 'Success', message: 'OTP verified successfully. Please Login');
      if(isFromSignUpScreen) {
        Get.toNamed(AppRoute.signInScreen);
      }
    } catch (e) {
      isOtpLoading.value = false;
      SnackBarConstant.error(title: 'Error', message: e.toString());
    } finally {
      isOtpLoading.value = false;
    }
  }
}