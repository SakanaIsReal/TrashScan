import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'app/router.dart';
import 'functions/diary_storage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DiaryStorage.insertMockData(); // mockup

  // ตรวจสอบว่าเคยสมัครบัญชีหรือยัง
  final prefs = await SharedPreferences.getInstance();
  final isRegistered = prefs.getBool('isRegistered') ?? false;
  final initialLocation = isRegistered ? '/' : '/account_registration';

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) async {
    await _initializeNotifications();
    runApp(MyApp(initialRoute: initialLocation));
  });
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter(initialRoute),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xff4F5C32),
      ),
    );
  }
}

Future<void> _initializeNotifications() async {
  debugPrint('⏳ Initializing notifications...');

  try {
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Bangkok');
    tz.setLocalLocation(location);

    await _createNotificationChannel();

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

    final bool permitted = await _requestNotificationPermissions();
    debugPrint(permitted ? '✅ Permission granted' : '❌ Permission denied');

    await scheduleDailyNotification();
  } catch (e) {
    debugPrint('‼️ ERROR: $e');
  }
}

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
}

Future<bool> _requestNotificationPermissions() async {
  final bool? granted = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  return granted ?? false;
}

Future<void> scheduleDailyNotification() async {
  try {
    final scheduledTime = _nextInstanceOf8AM();
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
  } catch (e) {
    debugPrint('‼️ Failed to schedule: $e');
  }
}

tz.TZDateTime _nextInstanceOf8AM() {
  final now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 8, 0);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}