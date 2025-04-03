import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'app/router.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) async {
    await _initializeNotifications();
    runApp(const MyApp());
  });
}

// ================== NOTIFICATION SETUP ==================
Future<void> _initializeNotifications() async {
  debugPrint('⏳ Initializing notifications...');
  
  try {
    // 1. Initialize Timezones
    debugPrint('🕒 Initializing timezones...');
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Bangkok'); // Change to your timezone
    tz.setLocalLocation(location);
    debugPrint('✅ Timezone set to: ${tz.local.name}');

    // 2. Create Notification Channel (Android)
    debugPrint('📱 Creating notification channel...');
    await _createNotificationChannel();

    // 3. Initialize Plugin
    debugPrint('🔌 Initializing notification plugin...');
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        debugPrint('📩 Notification tapped! Payload: $payload');
      },
    );
    debugPrint('✅ Plugin initialized');

    // 4. Request Permissions (Android 13+)
    debugPrint('🛂 Requesting notification permissions...');
    final bool permitted = await _requestNotificationPermissions();
    debugPrint(permitted ? '✅ Permission granted' : '❌ Permission denied');

    // 5. Test Immediate Notification
    debugPrint('🔔 Sending test notification...');
    await _sendTestNotification();

    // 6. Schedule Daily Notification
    debugPrint('⏰ Scheduling daily notification...');
    await scheduleDailyNotification();
  } catch (e) {
    debugPrint('‼️ ERROR: $e');
  }
}

// ================== HELPER FUNCTIONS ==================
Future<void> _createNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'daily_channel_id',
    'Daily Notifications',
    description: 'Daily reminder notifications',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  debugPrint('📳 Notification channel created');
}

Future<bool> _requestNotificationPermissions() async {
  final bool? granted = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  return granted ?? false;
}

Future<void> _sendTestNotification() async {
  await flutterLocalNotificationsPlugin.show(
    999, // Unique ID for test notification
    'TEST NOTIFICATION',
    'If you see this, notifications work!',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
      ),
    ),
  );
  debugPrint('📲 Test notification sent');
}

Future<void> scheduleDailyNotification() async {
  try {
    final scheduledTime = _nextInstanceOf8AM();
    debugPrint('⏱ Next notification scheduled for: $scheduledTime');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Daily Reminder",
      "Don't forget to log your trash today!",
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel_id',
          'Daily Notifications',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    debugPrint('✅ Daily notification scheduled');
  } catch (e) {
    debugPrint('‼️ Failed to schedule: $e');
  }
}

tz.TZDateTime _nextInstanceOf8AM() {
  final now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 8, 0); // 8 AM

  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }

  return scheduledDate;
}

// ================== TESTING WIDGET ==================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xff4F5C32),
      ),
      builder: (context, child) {
        // Add a debug button overlay in debug mode
        return Stack(
          children: [
            child!,
            if (kDebugMode)
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () async {
                    debugPrint('🎯 Manually triggering test notification...');
                    await _sendTestNotification();
                    await scheduleDailyNotification();
                  },
                  child: const Icon(Icons.notification_add),
                ),
              ),
          ],
        );
      },
    );
  }
}