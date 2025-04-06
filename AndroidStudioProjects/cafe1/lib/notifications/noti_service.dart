import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialize notification service
  Future<void> initNotification() async {
    if (_isInitialized) return;

    // Android initialization settings
    const AndroidInitializationSettings initSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialization settings
    const InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
    );

    // Initialize the plugin
    try {
      await flutterLocalNotificationsPlugin.initialize(initSettings);
      _isInitialized = true;
    } catch (e) {
      print("Error initializing notifications: $e");
    }
  }

  // Setup notification details for Android
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'buy_id',
        'Buy Notification',
        channelDescription: 'Buy Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  // Show notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(),
      );
    } catch (e) {
      print("Error showing notification: $e");
    }
  }
}
