import 'package:easy_push_notification/easy_push_notification.dart';
import 'package:get/get.dart';
import '../utils/logging/logger.dart';
import 'network_caller.dart';
import 'storage_service.dart';
import '../utils/constants/api_constants.dart';

class FCMService extends GetxService {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  String? _currentToken;

  /// Initialize FCM and listen for token changes
  Future<void> initialize() async {
    // DON'T initialize Firebase here - EasyPush already did it

    // Get initial token
    _currentToken = await EasyPush.I.getToken();
    AppLoggerHelper.info('Initial FCM Token: $_currentToken');

    // Listen for token refresh
    EasyPush.I.onTokenRefresh.listen((newToken) {
      AppLoggerHelper.info('FCM Token Refreshed: $newToken');
      _currentToken = newToken;

      // If user is logged in, update token on server
      if (StorageService.accessToken != null) {
        registerToken(newToken);
      }
    });
  }

  /// Register FCM token to server
  Future<bool> registerToken(String token) async {
    try {
      final response = await _networkCaller.postRequest(
        ApiConstant.baseUrl + ApiConstant.registerFcmToken,
        body: {
          'token': token,
          'platform': GetPlatform.isAndroid ? 'ANDROID' : 'IOS',
          'deviceId': await _getDeviceId(),
        },
      );

      if (response.isSuccess) {
        // Save token locally
        await StorageService.saveFcmToken(fcm: token);
        AppLoggerHelper.info('FCM Token registered successfully');
        return true;
      } else {
        AppLoggerHelper.error('Failed to register FCM token: ${response.errorMessage}');
        return false;
      }
    } catch (e) {
      AppLoggerHelper.error('Error registering FCM token: $e');
      return false;
    }
  }

  /// Remove FCM token from server
  Future<bool> removeToken() async {
    try {
      final savedToken = StorageService.fcmToken;
      if (savedToken == null) {
        AppLoggerHelper.info('No FCM token to remove');
        return true;
      }

      final response = await _networkCaller.deleteRequest(
        ApiConstant.baseUrl + ApiConstant.removeFcmToken,
        body: {
          'token': savedToken,
        },
      );

      if (response.isSuccess) {
        // Clear local token
        await StorageService.clearFcmToken();
        AppLoggerHelper.info('FCM Token removed successfully');
        return true;
      } else {
        AppLoggerHelper.error('Failed to remove FCM token: ${response.errorMessage}');
        return false;
      }
    } catch (e) {
      AppLoggerHelper.error('Error removing FCM token: $e');
      return false;
    }
  }

  /// Get current FCM token
  String? get currentToken => _currentToken;

  /// Get device ID for tracking
  Future<String> _getDeviceId() async {
    // You can use device_info_plus package or generate a unique ID
    // For now, using a simple timestamp-based ID
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}