import 'package:get/get.dart';

import '../../../core/services/network_caller.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/api_constants.dart';
import '../../../core/utils/constants/snackbar_constant.dart';
import '../../home/model/pro_tips_model.dart';

class ProTipsItem {
  final String title;
  final String iconColor;
  final List<String> tips;
  final RxBool isExpanded;

  ProTipsItem({
    required this.title,
    required this.iconColor,
    required this.tips,
    required this.isExpanded,
  });
}

class ProTipsController extends GetxController {
  var items = <ProTipsItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProTips();
  }

  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  RxBool isProTipsLoading = false.obs;
  RxBool isProTipsError = false.obs;

  Rx<ProTipsModel?> proTipsData = Rx<ProTipsModel?>(null);

  Future<void> getProTips() async {
    try {
      isProTipsLoading.value = true;
      isProTipsError.value = false;
      final token = StorageService.accessToken;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.proTips,
        token: token,
      );

      if (!response.isSuccess) {
        isProTipsLoading.value = false;
        isProTipsError.value = true;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }

      proTipsData.value = ProTipsModel.fromJson(response.responseData);
      _mapApiDataToItems(response.responseData['data']);
      isProTipsLoading.value = false;
      isProTipsError.value = false;
    } catch (e) {
      isProTipsLoading.value = false;
      isProTipsError.value = true;
      SnackBarConstant.errorThin(title: 'Failed', message: e.toString());
    } finally {
      isProTipsLoading.value = false;
    }
  }

  void _mapApiDataToItems(Map<String, dynamic> data) {
    List<ProTipsItem> tempItems = [];

    List<String> colors = [
      '0xFFF3F3FE', '0xFFF6F2FE', '0xFFFEF1F7', '0xFFFEF7EC',
      '0xFFECFAF5', '0xFFF0F5FE', '0xFFEDF9F8', '0xFFFEF0F0', '0xFFFFF4ED'
    ];

    int colorIndex = 0;

    data.forEach((key, value) {
      tempItems.add(
        ProTipsItem(
          title: key,
          iconColor: colors[colorIndex % colors.length],
          tips: List<String>.from(value),
          isExpanded: false.obs,
        ),
      );
      colorIndex++;
    });

    items.assignAll(tempItems);
  }

  ProTipsItem getPlaceholderItem() {
    return ProTipsItem(
      title: 'Loading Pro Tip Title',
      iconColor: '0xFFE5E7EB',
      tips: ['This is a loading tip placeholder', 'Another placeholder tip'],
      isExpanded: false.obs,
    );
  }

  void toggleExpanded(int index) {
    items[index].isExpanded.toggle();
  }

  void closeAll() {
    for (var item in items) {
      item.isExpanded.value = false;
    }
  }
}
