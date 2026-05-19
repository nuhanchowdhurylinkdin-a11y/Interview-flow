import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/nav_screens/profile/view_profile/controllers/profile_controller.dart';
import 'package:dtc6464/features/nav_screens/profile/view_profile/widgets/logout_button.dart';
import 'package:dtc6464/features/nav_screens/profile/view_profile/widgets/profile_card.dart';
import 'package:dtc6464/features/nav_screens/profile/view_profile/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                IconPath.profileEditIcon,
                width: 40.w,
                height: 40.h,
              ),
              onPressed: () => controller.navigateToEditProfile(context),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => controller.getProfile(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  28.verticalSpace,

                  // Profile Card with Skeletonizer
                  Obx(() => Skeletonizer(
                    enabled: controller.isProfileLoading.value,
                    child: ProfileCard(
                      userName: controller.userName.value,
                      avatarUrl: controller.userAvatar.value,
                    ),
                  )),

                  20.verticalSpace,

                  // Menu Items Section (Static, so no skeleton needed unless content is dynamic)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(14.w),
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
                    child: Column(
                      children: [
                        ProfileMenuItem(
                          icon: IconPath.statisticsIcon,
                          title: 'Statistics',
                          subtitle: 'View your progress',
                          backgroundColor: const Color(0xFFEFF6FF),
                          onTap: controller.navigateToStatistics,
                        ),
                        SizedBox(height: 24.h),
                        ProfileMenuItem(
                          icon: IconPath.notificationsIcon,
                          title: 'Notifications',
                          subtitle: 'Manage preferences',
                          backgroundColor: const Color(0xFFFFF8E4),
                          onTap: () => controller.navigateToNotifications(context),
                        ),
                        SizedBox(height: 24.h),
                        ProfileMenuItem(
                          icon: IconPath.historyIcon,
                          title: 'History',
                          subtitle: 'Manage preferences',
                          backgroundColor: const Color(0xFFFEF2F9),
                          onTap: () => controller.navigateToHistory(context),
                        ),
                        SizedBox(height: 24.h),
                        ProfileMenuItem(
                          icon: IconPath.upload,
                          title: 'Resumes',
                          subtitle: 'Add or remove resumes',
                          backgroundColor: const Color(0xFFEFF6FF),
                          onTap: () => controller.navigateToResumes(context),
                        ),
                        SizedBox(height: 24.h),
                        ProfileMenuItem(
                          icon: IconPath.bag,
                          title: 'Roles',
                          subtitle: 'Manage your roles',
                          backgroundColor: const Color(0xFFFFF8E4),
                          onTap: () => controller.navigateToRoles(context),
                        ),
                      ],
                    ),
                  ),

                  20.verticalSpace,
                  LogoutButton(onPressed: controller.logout),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
