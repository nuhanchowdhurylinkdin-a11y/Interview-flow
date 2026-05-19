import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Background(
        child: SafeArea(
          child: Obx(() {
            if (controller.isAvatarLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  const Text("Full Name", style: TextStyle(fontWeight: FontWeight.bold)),
                  8.verticalSpace,
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  24.verticalSpace,
                  const Text("Choose Avatar", style: TextStyle(fontWeight: FontWeight.bold)),
                  16.verticalSpace,

                  // Reusing AvatarGridWidget logic
                  if (controller.avatarsData.value != null)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                      ),
                      itemCount: controller.avatarsData.value!.data.length,
                      itemBuilder: (context, index) {
                        final avatar = controller.avatarsData.value!.data[index];

                        AppLoggerHelper.info(avatar.fileUrl);
                        return GestureDetector(
                          onTap: () => controller.selectAvatar(avatar.id),
                          child: Obx(() => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: controller.selectedAvatarId.value == avatar.id
                                    ? Colors.purple
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("https://api.datatechcon.com${avatar.fileUrl}"),
                            ),
                          )),
                        );
                      },
                    ),

                  40.verticalSpace,
                  CustomFilledButton(
                    text: 'Save Changes',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.updateProfile,
                  ),
                  20.verticalSpace,
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}