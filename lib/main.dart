import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:whilabel_renewal/design_guide_managers/whilabel_theme.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view.dart';
import 'package:whilabel_renewal/screen/login/login_view.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_page.dart';
import 'package:whilabel_renewal/screen/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'design_guide_managers/whilabel_theme.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Channel',
  description: 'This channel is used for important notifications',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

 /*TODO Background 상태일때 수행 할 로직 **/
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));


  runApp(const MyApp());
  if (Platform.isAndroid || Platform.isIOS) {
    FirebaseMessaging? messaging;
    messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: ProviderScope(
          child: MaterialApp(
        routes: {
          Routes.main_tab: (context) => MainBottomTabPage(),
          Routes.login: (context) => LoginView(),
        },
        title: 'Flutter Demo',
        theme: whilabelTheme,
        home: MockHomeView(),
      )),
    );
  }
}
