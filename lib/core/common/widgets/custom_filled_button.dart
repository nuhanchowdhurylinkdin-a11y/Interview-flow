import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/icon_path.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isIcon = false,
    this.icon = IconPath.arrowRightFilled,
    this.gradient,
    this.color,
    this.textColor,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool? isIcon;
  final String icon;
  final Gradient? gradient;
  final Color? color;
  final Color? textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final effectiveGradient =
        gradient ??
        const LinearGradient(
          begin: Alignment(-0.7, -0.8),
          end: Alignment(0.7, 0.8),
          colors: [Color(0xFFA78BFA), Color(0xFF5835C0)],
          stops: [0.1541, 0.8459],
        );

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(60.r),
          gradient: color != null ? null : effectiveGradient,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 24.h,
                  width: 24.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor ?? AppColors.whiteLight,
                      ),
                    ),
                    if (isIcon ?? false) ...[
                      10.horizontalSpace,
                      Image.asset(icon, width: 20.w),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
