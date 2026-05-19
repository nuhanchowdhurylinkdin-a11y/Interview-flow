import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/pro_tips/controllers/pro_tips_controller.dart';
import 'package:dtc6464/features/pro_tips/widgets/pro_tips_dropdown_item.dart';
import 'package:dtc6464/features/pro_tips/widgets/pro_tips_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';

class ProTipsScreen extends StatelessWidget {
  const ProTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProTipsController());

    return RefreshIndicator(
      onRefresh: () async {
        controller.getProTips();
      },
      child: Background(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Pro Tips',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 14.h,
              children: [
                SizedBox(height: 2.h),
                const ProTipsInfoCard(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Obx(() {
                    final bool isLoading = controller.isProTipsLoading.value;
                    final bool isError = controller.isProTipsError.value;

                    if (isLoading) {
                      final displayItems = List.generate(6, (index) => controller.getPlaceholderItem());
                      return _buildProTipsList(displayItems, true);
                    }

                    if (isError) {
                      return Center(
                        child: InkWell(
                          onTap: () => controller.getProTips(),
                          child: Column(
                            children: [
                              const Icon(Icons.refresh),
                              10.verticalSpace,
                              Text(
                                'Try Again',
                                style: getTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return _buildProTipsList(controller.items, false);
                  })
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProTipsList(List<ProTipsItem> displayItems, bool enabled) {
    return Skeletonizer(
      enabled: enabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 14.h,
        children: displayItems.map((item) {
          return ProTipsDropdownItem(
            item: item,
            index: displayItems.indexOf(item),
          );
        }).toList(),
      ),
    );
  }
}
