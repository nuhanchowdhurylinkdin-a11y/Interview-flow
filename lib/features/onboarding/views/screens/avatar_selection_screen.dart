import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/core/utils/constants/image_path.dart';
import 'package:dtc6464/core/utils/constants/snackbar_constant.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/onboarding/controllers/avatar_selection_controller.dart';
import 'package:dtc6464/features/onboarding/widgets/avatar_grid_widget.dart';
import 'package:dtc6464/features/onboarding/widgets/avatar_header_widget.dart';
import 'package:dtc6464/features/onboarding/widgets/avatar_progress_dots.dart';
import 'package:dtc6464/features/onboarding/widgets/start_interview_button.dart';
import 'package:dtc6464/features/onboarding/widgets/title_widget.dart';
import 'package:dtc6464/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AvatarSelectionScreen extends StatelessWidget {
  const AvatarSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvatarSelectionController());

    return Scaffold(
      body: Background(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Obx(() {
              if (controller.controller.isAvatarLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.controller.avatarsData.value == null) {
                return const Center(child: Text("No avatars found"));
              }
              return Column(
                children: [
                  60.verticalSpace,
                  43.horizontalSpace,
                  const AvatarHeaderWidget(),
                  56.verticalSpace,
                  const AvatarProgressDots(),
                  24.verticalSpace,
                  const TitleWidget(title: 'Choose your avatar'),
                  20.verticalSpace,
                  AvatarGridWidget(
                    avatars: controller.controller.avatarsData.value!.data,
                    selectedIndex: controller.selectedAvatarIndex.value,
                    onSelect: controller.selectAvatar,
                  ),
                  12.verticalSpace,
                  CustomFilledButton(
                    text: 'Start Interview',
                    isLoading: controller.isUpdateLoading.value,
                    onPressed: () {
                      if (!controller.isAvatarSelected()) {
                        SnackBarConstant.error(
                          title: "Select avatar",
                          message: "Please choose an avatar to continue",
                        );
                        return;
                      }
                      // Route to bottom navigation (clear previous stack)
                      controller.updateProfile();
                    },
                  ),
                  40.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 20.w);
            }),
          ),
        ),
      ),
    );
  }
}
