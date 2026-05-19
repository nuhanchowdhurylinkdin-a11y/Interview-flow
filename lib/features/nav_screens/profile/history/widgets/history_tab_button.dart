import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryTabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const HistoryTabButton({
    required this.label,
    required this.isActive,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF8F5FF) : const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isActive ? const Color(0xFFCBB5FF) : const Color(0xFFD9D9D9),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6.w,
          children: [
            Icon(
              Icons.calendar_month,
              color: isActive ? const Color(0xFF8A5CF6) : Colors.grey,
              size: 16.sp,
            ),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? const Color(0xFF8A5CF6)
                    : const Color(0xFF999EA7),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
