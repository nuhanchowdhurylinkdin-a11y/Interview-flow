import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/constants/snackbar_constant.dart';
import 'package:dtc6464/features/learning_roadmap/model/roadmap_model.dart';
import 'package:get/get.dart';

class LearningRoadmapController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();
  final motivationalMessage = 'Keep going! you\'re doing great'.obs;

  Rx<RoadmapModel?> roadmap = Rx<RoadmapModel?>(null);
  RxBool isRoadMapLoading = false.obs;
  RxBool isRoadMapError = false.obs;

  @override
  void onInit() {
    super.onInit();
    getRoadMap();
  }

  Future<void> getRoadMap() async {
    try {
      isRoadMapLoading.value = true;
      isRoadMapError.value = false;
      final token = StorageService.accessToken;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.roadMap,
        token: token,
      );
      
      if(!response.isSuccess) {
        isRoadMapLoading.value = false;
        isRoadMapError.value = true;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        return;
      }
      
      roadmap.value = RoadmapModel.fromJson(response.responseData);
      isRoadMapLoading.value = false;
      isRoadMapError.value = false;
    } catch (e) {
      isRoadMapLoading.value = false;
      isRoadMapError.value = true;
      SnackBarConstant.errorThin(title: 'Failed', message: e.toString());
    } finally {
      isRoadMapLoading.value = false;
    }
  }

  LearningArea getPlaceholderArea() {
    return LearningArea(
      id: "0",
      area: "Loading Area Name",
      progress: 0,
      progressPercentage: 0,
      topics: ["Topic 1", "Topic 2", "Topic 3"],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

}
