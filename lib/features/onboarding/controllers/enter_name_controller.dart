import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:dtc6464/features/onboarding/model/avatars_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/snackbar_constant.dart';

class EnterNameController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Rx<String> userName = ''.obs;

  RxBool isAvatarLoading = false.obs;
  RxBool isAvatarError = false.obs;

  Rx<AvatarsModel?> avatarsData = Rx<AvatarsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getAllAvatars();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void updateName(String value) {
    userName.value = value;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  String getUserName() => nameController.text.trim();

  void clearForm() {
    nameController.clear();
    userName.value = '';
  }

  Future<void> getAllAvatars() async {
    try {
      isAvatarLoading.value = true;
      isAvatarError.value = false;
      final token = StorageService.accessToken;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.avatar,
        token: token,
      );

      if(!response.isSuccess) {
        isAvatarLoading.value = false;
        isAvatarError.value = true;
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
        return;
      }

      avatarsData.value = AvatarsModel.fromJson(response.responseData);
      isAvatarLoading.value = false;
    } catch (e) {
      isAvatarLoading.value = false;
      isAvatarError.value = true;
      SnackBarConstant.error(title: 'Failed', message: e.toString());
    } finally {
      isAvatarLoading.value = false;
    }
  }

}
