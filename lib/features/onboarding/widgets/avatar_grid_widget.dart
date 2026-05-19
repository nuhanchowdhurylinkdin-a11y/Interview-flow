import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/features/onboarding/model/avatars_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarGridWidget extends StatelessWidget {
  final List<Datum> avatars;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  const AvatarGridWidget({
    required this.avatars,
    required this.selectedIndex,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: avatars.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final selected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelect(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.whiteLight,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: selected
                      ? AppColors.softPurpleNormal
                      : AppColors.softPurpleLight,
                  width: selected ? 2 : 1,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: AppColors.softPurpleNormal.withValues(
                            alpha: 0.12,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Image.network('https://api.datatechcon.com${avatars[index].fileUrl}', fit: BoxFit.contain),
              ),
            ),
          );
        },
      ),
    );
  }
}
