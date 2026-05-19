import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperienceCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ExperienceCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          // Background Color logic
          color: isSelected ? const Color(0xFFF2EEFE) : const Color(0xFFFFFFFF),
          // Border logic
          border: Border.all(
            color: isSelected ? const Color(0xFFA78BFA) : const Color(0xFFE4DBFD),
            width: 1,
          ),
          // The Shadow from your specs
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA0A0C8).withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF5835C0) : Colors.black87,
              ),
            ),
            // Optional: Radio-style indicator
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? const Color(0xFF5835C0) : const Color(0xFFE4DBFD),
            ),
          ],
        ),
      ),
    );
  }
}