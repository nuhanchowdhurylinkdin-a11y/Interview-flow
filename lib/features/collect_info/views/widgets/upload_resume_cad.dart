import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadResumeCad extends StatelessWidget {
  const UploadResumeCad({
    super.key,
    required this.text,
    required this.onTap,
    this.fileName,
    this.fileSize, required this.onDelete,
  });

  final String text;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final String? fileName; // Null if no file selected
  final String? fileSize; // Null if no file selected

  @override
  Widget build(BuildContext context) {
    final bool isFileSelected = fileName != null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
        decoration: BoxDecoration(
          // 1. Background: #FFF
          color: const Color(0xFFFFFFFF),

          // 2. Border Radius: 20px
          borderRadius: BorderRadius.circular(20.r),

          // 3. Border: 1px solid #F6F3FF
          border: Border.all(
            color: const Color(0xFFF6F3FF),
            width: 1,
          ),

          // 4. Box Shadow: 0 6px 12px 0 rgba(160, 160, 200, 0.10)
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA0A0C8).withOpacity(0.10),
              offset: const Offset(0, 6), // x: 0, y: 6
              blurRadius: 12,             // blur: 12
              spreadRadius: 0,            // spread: 0
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isFileSelected ? fileName! : text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: isFileSelected ? FontWeight.w600 : FontWeight.w500,
                      color: AppColors.softPurpleDarker,
                    ),
                  ),
                  if (isFileSelected) ...[
                    4.verticalSpace,
                    Text(
                      fileSize!,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.softPurpleNormal,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            10.horizontalSpace,
            // Switches between Upload Icon and Check Circle
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isFileSelected
                  ? Row(
                    children: [
                      Image.asset(IconPath.refresh, width: 25.w,),
                      15.horizontalSpace,
                      GestureDetector(
                        onTap: onDelete,
                          child: Image.asset(IconPath.close, width: 25.w,)),
                    ],
                  )
                  : Image.asset(IconPath.upload, width: 20.w, key: const ValueKey(2)),
            ),
          ],
        ),
      ),
    );
  }
}