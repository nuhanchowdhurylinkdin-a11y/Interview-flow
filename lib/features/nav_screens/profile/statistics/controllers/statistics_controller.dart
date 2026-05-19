import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constants/snackbar_constant.dart';
import '../model/statics_model.dart';

class StatisticsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStatistics();
  }

  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  RxBool isStatisticsLoading = false.obs;
  RxBool isStatisticsError = false.obs;
  Rx<StatisticsModel?> statistics = Rx<StatisticsModel?>(null);

  // Helper getter to access data safely
  Data? get statsData => statistics.value?.data;

  Future<void> getStatistics() async {
    try {
      isStatisticsLoading.value = true;
      isStatisticsError.value = false;

      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.statistics,
        token: StorageService.accessToken,
      );

      if (!response.isSuccess) {
        isStatisticsError.value = true;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }

      statistics.value = StatisticsModel.fromJson(response.responseData);
    } catch (e) {
      isStatisticsError.value = true;
      SnackBarConstant.errorThin(title: 'Error', message: e.toString());
    } finally {
      isStatisticsLoading.value = false;
    }
  }
}
