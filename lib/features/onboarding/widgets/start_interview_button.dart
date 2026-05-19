import 'package:dtc6464/core/common/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';

class StartInterviewButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartInterviewButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomFilledButton(
            text: 'Start Interview',
            onPressed: onPressed,
            isIcon: false,
          ),
        ),
      ],
    );
  }
}
