import 'package:dtc6464/core/common/styles/global_text_style.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalLinksSection extends StatelessWidget {
  const LegalLinksSection({super.key});

  static const String _baseDomain = 'https://dashboard.datatechcon.com';

  static final List<_LegalLink> _links = [
    _LegalLink('Terms & Conditions', '$_baseDomain/terms-and-conditions'),
    _LegalLink('Privacy Policy', '$_baseDomain/privacy-policy'),
    _LegalLink('Help Center', '$_baseDomain/help-center'),
    _LegalLink('About Us', '$_baseDomain/about-us'),
    _LegalLink('Contact Us', '$_baseDomain/contact-us'),
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 6.w,
          runSpacing: 4.h,
          children: _links.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _launchUrl(link.url),
                  child: Text(
                    link.label,
                    style: getTextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.softBlueDark,
                    ).copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                if (index < _links.length - 1)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Text(
                      '·',
                      style: getTextStyle(
                        fontSize: 11.sp,
                        color: AppColors.softPurpleNormal,
                      ),
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _LegalLink {
  final String label;
  final String url;
  const _LegalLink(this.label, this.url);
}
