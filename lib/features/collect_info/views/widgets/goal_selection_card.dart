import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalSelectionCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalSelectionCard({
    super.key,
    required this.text,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // 1. AnimatedContainer handles color and border transitions smoothly
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 55.h,
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF2EEFE) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFFA78BFA) : const Color(0xFFE4DBFD),
            width: isSelected ? 1.5 : 1, // Slight thickness change on selection
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA0A0C8).withOpacity(isSelected ? 0.12 : 0.08),
              offset: const Offset(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          children: [
            // 2. AnimatedScale makes the image "pop" slightly when selected
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Image.asset(imagePath, width: 24.w, height: 24.h),
            ),

            12.horizontalSpace,

            Expanded(
              child: Text(
                text,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppColors.softPurpleDarker : AppColors.softPurpleNormal,
                ),
              ),
            ),

            // 3. AnimatedSwitcher for a smooth icon swap (Outline to Filled)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                key: ValueKey<bool>(isSelected), // Required for AnimatedSwitcher to identify change
                color: isSelected ? AppColors.softBlueNormal : const Color(0xFFE4DBFD),
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}