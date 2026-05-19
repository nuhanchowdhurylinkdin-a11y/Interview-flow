import 'package:flutter/material.dart';

import '../../../../core/utils/constants/image_path.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePath.background),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
