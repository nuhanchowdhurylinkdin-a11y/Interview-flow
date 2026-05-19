import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/nav_screens/profile/resumes/controllers/resumes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResumesScreen extends StatelessWidget {
  const ResumesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResumesController());

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Resumes',
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
        floatingActionButton: Obx(() => controller.isUploading.value
            ? FloatingActionButton(
                onPressed: null,
                backgroundColor: AppColors.softPurpleDarker,
                child: SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : FloatingActionButton(
                onPressed: controller.addResume,
                backgroundColor: AppColors.softPurpleDarker,
                child: const Icon(Icons.add, color: Colors.white),
              ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: controller.fetchResumes,
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.resumes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description_outlined,
                          size: 64.sp, color: Colors.grey.shade400),
                      16.verticalSpace,
                      Text(
                        'No resumes uploaded yet',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        'Tap + to upload a resume',
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
                itemCount: controller.resumes.length,
                itemBuilder: (context, index) {
                  final resume = controller.resumes[index];
                  final fileName = resume.filename;

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
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(Icons.description,
                              color: AppColors.softPurpleDarker, size: 24.sp),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fileName,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF333333),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              4.verticalSpace,
                              Text(
                                'Resume ${index + 1}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xFF999EA7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => _showDeleteConfirmation(context, controller, index),
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
      BuildContext context, ResumesController controller, int index) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Resume'),
        content: const Text('Are you sure you want to remove this resume?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteResume(index);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red.shade400)),
          ),
        ],
      ),
    );
  }
}
