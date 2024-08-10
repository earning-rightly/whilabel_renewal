import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:whilabel_renewal/design_guide_managers/whilabel_theme.dart';
import 'package:whilabel_renewal/domain/notification_model.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view.dart';
import 'package:whilabel_renewal/screen/login/login_view.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_page.dart';
import 'package:whilabel_renewal/screen/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whilabel_renewal/singleton/hive_singleton.dart';
import 'firebase_options.dart';

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
  final notification = message.notification;

  IsolateNameServer.lookupPortByName('main_port')?.send({
    "title": notification?.title ?? "null",
    "content": notification?.body ?? "null body",
  });
}

void main() async {
  await dotenv.load(fileName: '.env');
  await HiveSingleton.setUpHive();

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
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.getAPNSToken();
    } else {}

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ReceivePort receivePort;

  @override
  void initState() {
    super.initState();
    receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(receivePort.sendPort, 'main_port');

    receivePort.listen((dynamic message) async {
      print(message);
      if (message is NotificationModel) {
        // set up the hive first
        await HiveSingleton.setUpHive();

        // then I try to change the data stored in the Hive box
        final fcmBox = HiveSingleton.getBox(NotificationModel.FCM);
        fcmBox.put(message.title, message.content);
      }
    });
  }

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
