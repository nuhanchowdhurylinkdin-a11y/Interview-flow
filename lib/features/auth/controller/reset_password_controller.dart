import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final emailController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }
}