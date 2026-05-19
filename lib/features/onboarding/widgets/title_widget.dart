import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: getTextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.softPurpleDarker,
          ),
        ),
      ],
    );
  }
}
