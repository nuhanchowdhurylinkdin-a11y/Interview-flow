import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/constants/snackbar_constant.dart';
import 'package:dtc6464/features/nav_screens/profile/view_profile/controllers/profile_controller.dart';
import 'package:dtc6464/features/onboarding/model/avatars_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {

  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  // Controllers & Keys
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Observables
  RxBool isLoading = false.obs;
  RxBool isAvatarLoading = false.obs;
  Rx<AvatarsModel?> avatarsData = Rx<AvatarsModel?>(null);
  Rx<String?> selectedAvatarId = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    final controller = Get.find<ProfileController>();
    nameController.text = controller.userName.value;
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await getAllAvatars();
    // Assuming you might want to pre-fill the name if you have it in Get.find<ProfileController>()
    // For now, it's a fresh edit state.
  }

  Future<void> getAllAvatars() async {
    try {
      isAvatarLoading.value = true;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.avatar,
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        avatarsData.value = AvatarsModel.fromJson(response.responseData);
      }
    } finally {
      isAvatarLoading.value = false;
    }
  }

  void selectAvatar(String id) {
    selectedAvatarId.value = id;
  }

  Future<void> updateProfile() async {
    if (nameController.text.isEmpty) {
      SnackBarConstant.error(title: "Error", message: "Name cannot be empty");
      return;
    }

    try {
      isLoading.value = true;
      final response = await _networkCaller.patchRequest(
        ApiConstant.baseUrl + ApiConstant.profileUpdate,
        body: {
          "fullName": nameController.text.trim(),
          if (selectedAvatarId.value != null) "profilePictureId": ?selectedAvatarId.value
        },
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        SnackBarConstant.success(title: 'Success', message: 'Profile updated');
        Get.back(); // Return to Profile Screen
      } else {
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
      }
    } finally {
      isLoading.value = false;
    }
  }

  List<dynamic> getAvatarPlaceholders() {
    return List.generate(6, (index) => null); // Just need a count for the shimmer
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}