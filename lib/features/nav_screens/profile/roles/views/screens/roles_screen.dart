import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/nav_screens/profile/roles/controllers/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RolesController());

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Target Roles',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => controller.showAddRoleDialog(context),
          backgroundColor: AppColors.softPurpleDarker,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: controller.fetchRoles,
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.targetRoles.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.work_outline,
                          size: 64.sp, color: Colors.grey.shade400),
                      16.verticalSpace,
                      Text(
                        'No target roles added yet',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        'Tap + to add a role',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: controller.targetRoles.length,
                itemBuilder: (context, index) {
                  final role = controller.targetRoles[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 24.r,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E4),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(Icons.work_outline,
                              color: AppColors.softPurpleDarker, size: 24.sp),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Text(
                            role,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _showDeleteConfirmation(context, controller, role),
                          icon: Icon(Icons.delete_outline,
                              color: Colors.red.shade400, size: 22.sp),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, RolesController controller, String role) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Role'),
        content: Text('Remove "$role" from your target roles?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteRole(role);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red.shade400)),
          ),
        ],
      ),
    );
  }
}
