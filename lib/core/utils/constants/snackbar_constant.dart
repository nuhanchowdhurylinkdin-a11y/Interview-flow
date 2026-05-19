import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'colors.dart';

class SnackBarConstant {
  SnackBarConstant._();

  // Success SnackBar
  static success({required String title, required String message}) =>
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.success,
        colorText: AppColors.whiteLight,
        margin: EdgeInsets.all(15.w),
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 3),
      );

  // Error SnackBar
  static error({required String title, required String message}) =>
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error,
        colorText: AppColors.whiteLight,
        margin: EdgeInsets.all(15.w),
        icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
        duration: const Duration(seconds: 4),
      );

  // Warning SnackBar
  static warning({required String title, required String message}) =>
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.warning,
        colorText: AppColors.whiteLight,
        margin: EdgeInsets.all(15.w),
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
        duration: const Duration(seconds: 3),
      );


  /// Core logic for the thin snackbar
  static void _showThinSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Closes any existing snackbar so they don't stack awkwardly
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.showSnackbar(
      GetSnackBar(
        messageText: Row(
          children: [
            Icon(icon, color: Colors.white, size: 10.sp),
            12.horizontalSpace,
            Text(
              "$title: ",
              overflow: TextOverflow.ellipsis,
              style: getTextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            12.verticalSpace,
            Expanded(
              child: Text(
                message,
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor.withValues(alpha: 0.95),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.zero,
        borderRadius: 0,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
        duration: duration,
        isDismissible: true,
        animationDuration: const Duration(milliseconds: 400),
        snackStyle: SnackStyle.FLOATING,
      ),
    );
  }

  // --- Thin Success SnackBar ---
  static successThin({required String title, required String message}) =>
      _showThinSnackBar(
        title: title,
        message: message, // Title is ignored in thin style to save space
        backgroundColor: AppColors.success,
        icon: Icons.check_circle_outline_rounded,
      );

  // --- Thin Error SnackBar ---
  static errorThin({required String title, required String message}) =>
      _showThinSnackBar(
        title: title,
        message: message,
        backgroundColor: AppColors.error,
        icon: Icons.error_outline_rounded,
        duration: const Duration(seconds: 4),
      );

  // --- Thin Warning SnackBar ---
  static warningThin({required String title, required String message}) =>
      _showThinSnackBar(
        title: title,
        message: message,
        backgroundColor: AppColors.warning,
        icon: Icons.warning_amber_rounded,
      );
}
