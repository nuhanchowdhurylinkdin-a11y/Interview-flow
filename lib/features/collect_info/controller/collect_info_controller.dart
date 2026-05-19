import 'dart:convert';
import 'dart:io';

import 'package:dtc6464/core/services/native_file_picker.dart';
import 'package:dtc6464/core/utils/constants/colors.dart';
import 'package:dtc6464/core/utils/constants/icon_path.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:dtc6464/features/collect_info/model/ai_brief_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/services/network_caller.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/api_constants.dart';
import '../../../core/utils/constants/snackbar_constant.dart';
import '../../../routes/app_routes.dart';

class CollectInfoController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();
  RxInt currentPageIndex = 0.obs;
  // text controllers
  final TextEditingController roleController = TextEditingController();
  final TextEditingController rolePreparingController = TextEditingController();
  final TextEditingController interviewingCompanyController =
      TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();

  // Target roles (array)
  RxList<String> targetRoles = <String>[].obs;

  // upload loading
  RxBool isUploading = false.obs;

  // The list of companies
  final RxList<String> companies = [
    'Google',
    'Facebook',
    'Amazon',
    'Netflix',
    'Apple',
    'Microsoft',
    'Shopify',
    'Spotify',
    'Startup',
  ].obs;

  // Filtered companies based on search
  RxList<String> filteredCompanies = <String>[].obs;

  // Reactive list to store selected items
  var selectedCompanies = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCompanies.assignAll(companies);
    interviewingCompanyController.addListener(_filterCompanies);
  }

  void addTargetRole() {
    final role = rolePreparingController.text.trim();
    if (role.isEmpty) return;
    if (targetRoles.any((r) => r.toLowerCase() == role.toLowerCase())) return;
    targetRoles.add(role);
    rolePreparingController.clear();
  }

  void removeTargetRole(String role) {
    targetRoles.remove(role);
  }

  void _filterCompanies() {
    final query = interviewingCompanyController.text.trim().toLowerCase();
    if (query.isEmpty) {
      filteredCompanies.assignAll(companies);
    } else {
      filteredCompanies.assignAll(
        companies.where((c) => c.toLowerCase().contains(query)).toList(),
      );
    }
  }

  void addCompany() {
    final name = interviewingCompanyController.text.trim();
    if (name.isEmpty) return;
    // Avoid duplicates (case-insensitive)
    if (companies.any((c) => c.toLowerCase() == name.toLowerCase())) return;
    companies.add(name);
    selectedCompanies.add(name);
    interviewingCompanyController.clear();
  }

  void toggleSelection(String name) {
    if (selectedCompanies.contains(name)) {
      selectedCompanies.remove(name);
    } else {
      selectedCompanies.add(name);
    }
  }

  // List of levels
  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  // ai breaf data
  Rx<AiBriefModel?> aiBriefData = Rx<AiBriefModel?>(null);

  // Reactive variable for the selected level (initially Beginner)
  RxString selectedLevel = 'Beginner'.obs;

  void selectLevel(String level) {
    selectedLevel.value = level;
  }

  final List<String> goals = [
    'Improve behavioral answers',
    'Boost interview confidence',
    'Strengthen technical skills',
    'Track my progress',
    'Master STAR method',
    'Prepare for promotion',
    'Improve system design',
    'Prepare for upcoming interview',
  ].obs;

  final List<String> goalsIcon = [
    IconPath.star,
    IconPath.mic,
    IconPath.brain,
    IconPath.grow,
    IconPath.puzzle,
    IconPath.rocket,
    IconPath.gear,
    IconPath.bag,
  ];

  // Using a set or list to allow multiple selection
  var selectedGoals = <String>[].obs;

  void toggleGoal(String goal) {
    if (selectedGoals.contains(goal)) {
      // If it's already selected, always allow removing it
      selectedGoals.remove(goal);
    } else {
      // Only add if the current count is less than 3
      if (selectedGoals.length < 3) {
        selectedGoals.add(goal);
      } else {
        // Optional: Show a message to the user
        Get.snackbar(
          "Limit Reached",
          "You can only select up to 3 goals",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.softPurpleDarker,
          colorText: AppColors.whiteLight,
          margin: EdgeInsets.all(15.w),
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
        );
      }
    }
  }

  // weak areas
  final List<String> areas = [
    'Interview anxiety',
    'STAR structure',
    'Long answers',
    'Lack metrics',
    'System design',
    'Technical depth',
    'Thinking Of examples',
    'Filler words',
  ].obs;

  final List<String> areasIcon = [
    IconPath.anxiety,
    IconPath.crown,
    IconPath.noteBook,
    IconPath.human,
    IconPath.monitor,
    IconPath.monitorSetting,
    IconPath.pencil,
    IconPath.speaker,
  ].obs;

  // Using a set or list to allow multiple selection
  var selectedAreas = <String>[].obs;

  void toggleArea(String area) {
    if (selectedAreas.contains(area)) {
      selectedAreas.remove(area);
    } else {
      selectedAreas.add(area);
    }
  }

  var resumes = <int, ResumeModel?>{1: null, 2: null, 3: null}.obs;

  // Logic to check if at least one resume exists
  bool get hasAtLeastOneResume => resumes.values.any((file) => file != null);

  Future<void> pickResume(int index) async {
    try {
      if (Platform.isIOS) {
        // Use native scene-aware picker on iOS
        final result = await NativeFilePicker.pickFile();
        if (result != null) {
          final name = result['name'] as String;
          final ext = name.contains('.') ? name.split('.').last.toLowerCase() : '';

          if (!['pdf', 'doc', 'docx'].contains(ext)) {
            Get.snackbar('Invalid File', 'Please select a PDF, DOC, or DOCX file',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.softPurpleDarker,
              colorText: AppColors.whiteLight,
            );
            return;
          }

          final size = result['size'] as int;
          resumes[index] = ResumeModel(
            name: name,
            size: "${(size / 1024 / 1024).toStringAsFixed(1)} MB",
            path: result['path'] as String,
          );
        }
      } else {
        // Use file_picker on Android
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx'],
        );

        if (result != null && result.files.isNotEmpty) {
          final file = result.files.first;
          final ext = file.extension?.toLowerCase() ?? '';

          if (!['pdf', 'doc', 'docx'].contains(ext)) {
            Get.snackbar('Invalid File', 'Please select a PDF, DOC, or DOCX file',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.softPurpleDarker,
              colorText: AppColors.whiteLight,
            );
            return;
          }

          resumes[index] = ResumeModel(
            name: file.name,
            size: "${(file.size / 1024 / 1024).toStringAsFixed(1)} MB",
            path: file.path ?? '',
          );
        }
      }
    } catch (e, st) {
      AppLoggerHelper.error('pickResume error: $e\n$st');
      Get.snackbar('Error', 'Failed to pick file: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.softPurpleDarker,
        colorText: AppColors.whiteLight,
      );
    }
  }

  void validateAndNext(PageController pageController) {
    String errorMessage = "";

    // Check which page the user is currently on
    switch (currentPageIndex.value) {
      case 0:
        if (roleController.text.trim().isEmpty) {
          errorMessage = "Please enter your current role";
        }
      case 1: // Target Roles
        if (targetRoles.isEmpty) {
          errorMessage = "Please add at least one target role";
        }
        break;

      case 2: // Company Selection (Chips)
        if (selectedCompanies.isEmpty)
          errorMessage = "Please select at least one company";
        break;

      case 3: // Experience Level (Always has Beginner selected, but safe to check)
        if (selectedLevel.value.isEmpty)
          errorMessage = "Please select your experience level";
        break;

      case 4: // Career Goals (Must be exactly 3)
        if (selectedGoals.length < 3)
          errorMessage = "Please select 3 career goals to continue";
        break;

      case 5: // Weak Areas
        if (selectedAreas.isEmpty)
          errorMessage = "Please select at least one area to improve";
        break;

      case 6: // Job Description (optional)
        break;
      case 7: // Resume Upload (optional)
        break;
    }

    // If there is an error message, show the snackbar and STOP
    if (errorMessage.isNotEmpty) {
      Get.snackbar(
        "Required Information",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.softPurpleDarker,
        colorText: AppColors.whiteLight,
        margin: EdgeInsets.all(15.w),
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      );
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }


  Future<void> analyzeProfile() async {
    try {
      isUploading.value = true;

      final Map<String, String> body = {
        'currentRole': roleController.text.trim(),
        'targetRole': jsonEncode(targetRoles),
        'experienceLevel': selectedLevel.value,
        'jobDescription': jobDescriptionController.text.trim(),
        'targetCompany': jsonEncode(selectedCompanies),
        'careerGoals': jsonEncode(selectedGoals),
        'weakAreas': jsonEncode(selectedAreas),
        'strengths': jsonEncode([]),
      };

      List<String> resumePaths = resumes.values
          .where((resume) => resume != null)
          .map((resume) => resume!.path)
          .toList();

      final response = await _networkCaller.postMultipartRequest(
        ApiConstant.baseUrl + ApiConstant.analyze,
        fields: body,
        filePaths: resumePaths,
      );

      if (response.isSuccess) {
        aiBriefData.value = AiBriefModel.fromJson(response.responseData);
        await StorageService.saveUserProfileId(aiBriefData.value!.data.userProfileId);
        SnackBarConstant.success(title: "Success", message: "Profile analyzed successfully!");
        Get.offAllNamed(AppRoute.getAiBriefScreen());
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Error', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text(response.errorMessage, style: const TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(15),
            duration: const Duration(seconds: 3),
          ),
        );
        Get.back();
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Error', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Text(e.toString(), style: const TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 3),
        ),
      );
      AppLoggerHelper.error(e.toString());
      Get.back();
    } finally {
      isUploading.value = false;
    }
  }

  @override
  void onClose() {
    interviewingCompanyController.removeListener(_filterCompanies);
    super.onClose();
  }
}

class ResumeModel {
  final String name;
  final String size;
  final String path;

  ResumeModel({required this.name, required this.size, required this.path});
}
