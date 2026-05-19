import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          // Background: White if unselected, Soft Purple Light if selected
          color: isSelected ? const Color(0xFFF2EEFE) : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            // Border: Light Active if unselected, Normal Purple if selected
            color: isSelected ? const Color(0xFFA78BFA) : const Color(0xFFE4DBFD),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFFA78BFA) : Color(0xFFA78BFA),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}