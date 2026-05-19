import 'package:dtc6464/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterNameHeader extends StatelessWidget {
  const EnterNameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Image.asset(ImagePath.roboatHead, width: 82.w),
        ),
        12.horizontalSpace,
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 8.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                ImagePath.enterNameMessage,
                width: 237.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
