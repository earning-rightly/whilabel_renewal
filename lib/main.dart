import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_page.dart';
import 'package:whilabel_renewal/screen/route/routes.dart';

void main() async{
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
          routes: {
            Routes.main_tab: (context) => MainBottomTabPage(),
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsManager.black100,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: MockHomeView(),
        ));
  }
}
