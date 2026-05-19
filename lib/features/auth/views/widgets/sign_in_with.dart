import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInWith extends StatelessWidget {
  const SignInWith({super.key, required this.icon, required this.methodNane});

  final String icon;
  final String methodNane;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // White-Light (#FFF)
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE4DBFD), // Soft Purple Light Active (#E4DBFD)
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {

        },
        borderRadius: BorderRadius.circular(16.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
             icon,
              height: 24.h,
            ),
            12.horizontalSpace,
            Text(
              "Continue with $methodNane",
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.softPurpleDarker,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
