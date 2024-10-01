import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:zini_pay_task/src/features/data/helpers/dio_helper.dart';
import 'src/my_app.dart';

final Dio dio = Dio();
final DioHelper dioHelper = DioHelper(dio: dio);

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'syncSmsTask') {
      final response = await dioHelper.syncSms(inputData!);
      response.fold(
        (failure) {
          _showNotification(failure.message);
        },
        (result) {
          _showNotification('SMS synced successfully');
        },
      );

      return Future.value(true);
    }
    return Future.value(false);
  });
}

void _showNotification(String message) {
  FlutterLocalNotificationsPlugin().show(
    0,
    'SMS Sync',
    message,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'sms_sync_channel',
        'SMS Sync Notifications',
        importance: Importance.max,
      ),
    ),
  );
}

void _localNotificationInit() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) => null,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: null,
      onDidReceiveBackgroundNotificationResponse: null);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _localNotificationInit();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(const MyApp());
}
