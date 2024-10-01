import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:zini_pay_task/src/core/media_query.dart';
import 'package:zini_pay_task/src/core/utils/app_colors.dart';

import '../../../config/routes_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool isSyncing = false;
  bool isSyncingActivated = false;
  bool isAppInBackground = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      isAppInBackground = state == AppLifecycleState.paused;
    });
    if (isAppInBackground && isSyncing) {
      _startBackgroundSync();
    }
  }

  void _toggleSyncing() {
    if (isSyncing) {
      Workmanager().cancelAll();
      _showNotification('SMS Sync Stopped');
      setState(() {
        isSyncingActivated = false;
      });
    } else {
      if (isAppInBackground) {
        _startBackgroundSync();
      }
      _showNotification('SMS Sync Ready for Background');
      setState(() {
        isSyncingActivated = true;
      });
    }

    setState(() {
      isSyncing = !isSyncing;
    });
  }

  void _startBackgroundSync() {
    Workmanager().registerOneOffTask(
      'syncSmsTask',
      'syncSmsTask',
      inputData: {
        'message': 'Test message now',
        'from': '+1234567890',
        'timestamp': '2024-07-31T10:00:00Z',
      },
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSyncingActivated
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                    ),
                    child: Icon(
                      isSyncingActivated ? Icons.check_circle : Icons.cancel,
                      color: isSyncingActivated ? Colors.green : Colors.red,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isSyncingActivated ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isSyncingActivated ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _toggleSyncing,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isSyncingActivated ? 'Stop' : 'Start',
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: context.width / 1.1,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.allMessagesPage);
              },
              child: const Text(
                'View All Messages',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: context.width / 1.1,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.allCredentialsPage);
              },
              child: const Text('View all devices/login credentials',
                  style: TextStyle(color: AppColors.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
