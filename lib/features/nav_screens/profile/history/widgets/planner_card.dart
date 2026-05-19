import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlannerCard extends StatelessWidget {
  final String title;
  final String dateAndRound;
  final String status; // "Scheduled" or "Completed"

  const PlannerCard({
    required this.title,
    required this.dateAndRound,
    required this.status,
    super.key,
  });

  Color _getStatusBgColor() {
    return status == 'Completed'
        ? const Color(0xFFCBEFE9)
        : const Color(0xFFE1F5FE);
  }

  Color _getStatusTextColor() {
    return status == 'Completed'
        ? const Color(0xFF34C759)
        : const Color(0xFF2A8EBA);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19A0A0C8),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: const Color(0xFF3A3158),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.75,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      dateAndRound,
                      style: TextStyle(
                        color: const Color(0xFF929294),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.75,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusBgColor(),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: _getStatusTextColor(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.75,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
