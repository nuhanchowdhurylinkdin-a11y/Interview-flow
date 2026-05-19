import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../controllers/pro_tips_controller.dart';

class ProTipsDropdownItem extends StatelessWidget {
  final ProTipsItem item;
  final int index;

  const ProTipsDropdownItem({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProTipsController>();

    return Container(
      width: 360.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => GestureDetector(
              onTap: () => controller.toggleExpanded(index),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                    bottomLeft: item.isExpanded.value
                        ? Radius.zero
                        : Radius.circular(14.r),
                    bottomRight: item.isExpanded.value
                        ? Radius.zero
                        : Radius.circular(14.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x14313131),
                      blurRadius: 20,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 6.w,
                  children: [
                    Container(
                      width: 46.w,
                      height: 46.w,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse('0xFF${item.iconColor.substring(2)}'),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: _getIconForCategory(item.title)),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 6.w,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: getTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 8.h,
                            ),
                            child: Transform.rotate(
                              angle: item.isExpanded.value ? 3.14159 : 0,
                              child: Icon(
                                Icons.expand_more,
                                size: 24.w,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => item.isExpanded.value
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x19000000),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 22.h,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 20.h,
                          children: item.tips
                              .map(
                                (tip) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 20.w,
                                  children: [
                                    Container(
                                      width: 16.w,
                                      height: 16.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.softPurpleNormal,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        tip,
                                        style: getTextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF505967),
                                          lineHeight: 1.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _getIconForCategory(String title) {
    switch (title) {
      case 'Interview Preparation':
        return Icon(
          Icons.work_outline,
          size: 20.w,
          color: const Color(0xFF7C3AED),
        );
      case 'During the interview':
        return Icon(Icons.people, size: 20.w, color: const Color(0xFF8B5CF6));
      case 'Technical Interviews':
        return Icon(Icons.code, size: 20.w, color: const Color(0xFFEC4899));
      case 'Body Language & Presence':
        return Icon(
          Icons.sentiment_satisfied,
          size: 20.w,
          color: const Color(0xFFFACC15),
        );
      case 'Behavioral Questions':
        return Icon(
          Icons.chat_bubble_outline,
          size: 20.w,
          color: const Color(0xFF10B981),
        );
      case 'Virtual Interviews':
        return Icon(Icons.videocam, size: 20.w, color: const Color(0xFF0EA5E9));
      case 'Salary Negotiation':
        return Icon(
          Icons.attach_money,
          size: 20.w,
          color: const Color(0xFF06B6D4),
        );
      case 'Follow-Up & Thank You':
        return Icon(
          Icons.mail_outline,
          size: 20.w,
          color: const Color(0xFFEF4444),
        );
      case 'Common Mistakes to Avoid':
        return Icon(Icons.warning, size: 20.w, color: const Color(0xFFF97316));
      default:
        return Icon(Icons.info_outline, size: 20.w);
    }
  }
}
