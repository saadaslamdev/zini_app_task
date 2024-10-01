import 'package:flutter/material.dart';
import 'package:zini_pay_task/src/features/presentation/credentials_page/all_credentials_page.dart';
import 'package:zini_pay_task/src/features/presentation/messages_page/all_messages_page.dart';
import 'package:zini_pay_task/src/features/presentation/home_page/home_page.dart';
import 'package:zini_pay_task/src/features/presentation/login_page/login_page.dart';

class Routes {
  static const String loginPage = "/login";
  static const String homePage = "/home";
  static const String allCredentialsPage = "/allCredentials";
  static const String allMessagesPage = "/allMessages";
}

class AppRounter {
  static Route? getRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.loginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case Routes.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case Routes.allCredentialsPage:
        return MaterialPageRoute(
            builder: (context) => const AllCredentialsPage());
      case Routes.allMessagesPage:
        return MaterialPageRoute(builder: (context) => const AllMessagesPage());
    }
    return null;
  }
}
