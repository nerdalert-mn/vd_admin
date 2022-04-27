import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vd_admin/controller/alert_controller.dart';
import 'package:vd_admin/controller/auth_controller.dart';
import 'package:vd_admin/controller/new_detection_controller.dart';
import 'package:vd_admin/controller/notification_controller.dart';
import 'package:vd_admin/pages/IntroPage.dart';
import 'package:vd_admin/pages/loading_page.dart';
import './pages/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AlertController());
    Get.put(AuthController());
    Get.put(NotificationController());
    Get.put(NewDetectionController());
    return GetMaterialApp(
        title: 'Violence Detection',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.pink,
            primaryColor: Colors.pink,
            appBarTheme: const AppBarTheme(elevation: 0)),
        home: const IntroPage());
  }
}
