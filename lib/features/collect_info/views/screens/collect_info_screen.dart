import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:dtc6464/features/background/views/widgets/background.dart';
import 'package:dtc6464/features/collect_info/views/page/page_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/common/widgets/custom_filled_button.dart';
import '../../../../routes/app_routes.dart';
import '../../controller/collect_info_controller.dart';
import '../page/page_2.dart';
import '../page/page_3.dart';
import '../page/page_4.dart';
import '../page/page_5.dart';
import '../page/page_6.dart';
import '../page/page_7.dart';
import '../page/page_8.dart';

class CollectInfoScreen extends StatelessWidget {
  CollectInfoScreen({super.key});

  final PageController _pageController = PageController();
  final CollectInfoController _controller = Get.put(CollectInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Obx(() {
              if(_controller.currentPageIndex.value == 0) {
                return SizedBox();
              }
              return Align(
                alignment: Alignment.centerLeft,
                child: RotatedBox(
                  quarterTurns: 90,
                  child: GestureDetector(
                    onTap: () {
                      if (_controller.currentPageIndex.value != 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Image.asset(
                      IconPath.arrowRightFilled,
                      width: 20.w,
                      color: AppColors.softPurpleDarker,
                    ),
                  ),
                ).paddingOnly(left: 20.w),
              );
            }),

            30.verticalSpace,
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int index) {
                  _controller.currentPageIndex.value = index;
                  AppLoggerHelper.debug(index.toString());
                },
                children: [
                  Page1(
                    pageController: _pageController,
                    controller: _controller,
                  ),
                  Page2(
                    pageController: _pageController,
                    controller: _controller,
                  ),
                  Page3(
                    pageController: _pageController,
                    controller: _controller,
                  ),
                  Page4(
                    pageController: _pageController,
                    controller: _controller,
                  ),
                  Page5(
                    pageController: _pageController,
                    controller: _controller,
                  ),
                  Page6(
                    pageController: _pageController,
                    controller: _controller,
                  ),
                  Page7(
                    pageController: _pageController,
                    controller: _controller,
                  ),
                  Page8(
                    pageController: _pageController,
                    controller: _controller,
                  ),
                ],
              ),
            ),

            Obx(() {
              return CustomFilledButton(
                text: _controller.currentPageIndex.value == 7
                    ? 'Finis Setup'
                    : 'Continue',
                isLoading: _controller.isUploading.value,
                onPressed: () {
                  if(_controller.currentPageIndex.value == 7) {
                    Get.toNamed(AppRoute.getProfileAnalyzingScreen());
                  } else {
                    _controller.validateAndNext(_pageController);
                  }
                },
                isIcon: true,
              ).paddingSymmetric(horizontal: 36.w);
            }),

            20.verticalSpace,

            // 2. The Indicator
            SmoothPageIndicator(
              controller: _pageController, // Pass the same controller here
              count: 8, // Number of pages
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.softBlueNormal,
                dotColor: AppColors.softBlueNormal,
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 4,
              ),
            ),

            60.verticalSpace,
          ],
        ),
      ),
    );
  }
}
