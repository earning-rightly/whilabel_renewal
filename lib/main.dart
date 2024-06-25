import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view.dart';

import 'design_guide_managers/whilabel_theme.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: ProviderScope(
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: whilabelTheme,
        home: MockHomeView(),
      )),
    );
  }
}
