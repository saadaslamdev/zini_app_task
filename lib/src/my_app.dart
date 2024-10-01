import 'package:flutter/material.dart';
import 'package:zini_pay_task/src/config/routes_manager.dart';
import 'package:zini_pay_task/src/config/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeAnimationCurve: Curves.fastOutSlowIn,
      debugShowCheckedModeBanner: false,
      title: 'Zini Pay Task',
      theme: getAppTheme(),
      initialRoute: Routes.loginPage,
      onGenerateRoute: AppRounter.getRoute,
    );
  }
}
