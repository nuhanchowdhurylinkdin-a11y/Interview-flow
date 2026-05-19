import 'package:dtc6464/app.dart';
import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:easy_push_notification/easy_push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'core/services/fcm_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 1. Initialize Firebase FIRST
    // This creates the [DEFAULT] app that EasyPush is looking for
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    AppLoggerHelper.info('🔥 Firebase initialized');

    // 2. Initialize Storage
    await StorageService.init();
    AppLoggerHelper.info('✅ Storage initialized');

    // 3. Initialize NetworkCaller
    Get.put(NetworkCaller(), permanent: true);
    AppLoggerHelper.info('✅ NetworkCaller initialized');

    // 4. Initialize EasyPush (Now it will find the Firebase app)
    await EasyPush.I.initialize(
      EasyPushConfig(
        androidChannelId: 'default_channel',
        androidChannelName: 'General Notifications',
        requestIOSPermissions: true,
        showForegroundNotifications: true,
        onNotificationTap: (payload) async {
          AppLoggerHelper.info('🔔 Notification tapped: $payload');
        },
      ),
    );
    AppLoggerHelper.info('✅ EasyPush initialized');

    // 5. Initialize FCMService
    await Get.putAsync(() async {
      final fcmService = FCMService();
      await fcmService.initialize();
      return fcmService;
    });
    AppLoggerHelper.info('✅ FCMService initialized');

    final token = await EasyPush.I.getToken();
    AppLoggerHelper.info('🔑 FCM Token: $token');

  } catch (e, stack) {
    AppLoggerHelper.error('❌ Initialization error: $e');
    AppLoggerHelper.error('Stack: $stack');
  }

  runApp(const MyApp());
}

