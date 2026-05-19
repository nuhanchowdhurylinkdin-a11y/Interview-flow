import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/features/onboarding/controllers/enter_name_controller.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/snackbar_constant.dart';
import '../../../routes/app_routes.dart';

class AvatarSelectionController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();
  final EnterNameController controller = Get.find<EnterNameController>();
  Rx<int?> selectedAvatarIndex = Rx<int?>(null);
  RxBool isUpdateLoading = false.obs;

  void selectAvatar(int index) {
    selectedAvatarIndex.value = index;
  }

  bool isAvatarSelected() => selectedAvatarIndex.value != null;

  int? getSelectedAvatar() => selectedAvatarIndex.value;

  void resetSelection() {
    selectedAvatarIndex.value = null;
  }

  Future<void> updateProfile() async {
    try {
      isUpdateLoading.value = true;
      final token = StorageService.accessToken;
      final response = await _networkCaller.patchRequest(
        ApiConstant.baseUrl + ApiConstant.profileUpdate,
        body: {
          "fullName": controller.nameController.text,
          "profilePictureId": controller.avatarsData.value!.data[selectedAvatarIndex.value ?? 0].id
        },
        token: token
      );

      if(!response.isSuccess) {
        isUpdateLoading.value = false;
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
      }

      isUpdateLoading.value = false;
      SnackBarConstant.success(title: 'Success', message: 'Profile updated successfully');
      Get.offAllNamed(AppRoute.bottomNavBar);
    } catch (e) {
      isUpdateLoading.value = false;
      SnackBarConstant.error(title: 'Failed', message: e.toString());
    } finally {
      isUpdateLoading.value = false;
    }
  }
}
