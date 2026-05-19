import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/constants/snackbar_constant.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RolesController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  final TextEditingController roleInputController = TextEditingController();

  RxList<String> targetRoles = <String>[].obs;
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRoles();
  }

  @override
  void onClose() {
    roleInputController.dispose();
    super.onClose();
  }

  Future<void> fetchRoles() async {
    try {
      isLoading.value = true;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.targetRole,
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        final data = response.responseData['data'];
        if (data != null && data['targetRole'] != null) {
          targetRoles.assignAll(List<String>.from(data['targetRole']));
        }
      } else {
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
      }
    } catch (e) {
      AppLoggerHelper.error('Error fetching roles: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addRole(String role) async {
    if (role.trim().isEmpty) return;
    if (targetRoles.any((r) => r.toLowerCase() == role.trim().toLowerCase())) {
      SnackBarConstant.error(title: 'Duplicate', message: 'Role already exists');
      return;
    }

    try {
      isSaving.value = true;
      final response = await _networkCaller.postRequest(
        ApiConstant.baseUrl + ApiConstant.targetRole,
        body: {'role': role.trim()},
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        final data = response.responseData['data'];
        if (data != null && data['targetRole'] != null) {
          targetRoles.assignAll(List<String>.from(data['targetRole']));
        }
        SnackBarConstant.success(title: 'Success', message: 'Role added');
      } else {
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
      }
    } catch (e) {
      SnackBarConstant.error(title: 'Error', message: 'Failed to add role');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteRole(String role) async {
    try {
      isSaving.value = true;
      final response = await _networkCaller.deleteRequest(
        ApiConstant.baseUrl + ApiConstant.targetRole,
        body: {'role': role},
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        final data = response.responseData['data'];
        if (data != null && data['targetRole'] != null) {
          targetRoles.assignAll(List<String>.from(data['targetRole']));
        }
        SnackBarConstant.success(title: 'Success', message: 'Role removed');
      } else {
        SnackBarConstant.error(title: 'Failed', message: response.errorMessage);
      }
    } catch (e) {
      SnackBarConstant.error(title: 'Error', message: 'Failed to remove role');
    } finally {
      isSaving.value = false;
    }
  }

  void showAddRoleDialog(BuildContext context) {
    roleInputController.clear();
    Get.dialog(
      AlertDialog(
        title: const Text('Add Role'),
        content: TextField(
          controller: roleInputController,
          decoration: InputDecoration(
            hintText: 'Enter role name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              addRole(roleInputController.text);
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
