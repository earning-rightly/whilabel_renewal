import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';
import 'package:whilabel_renewal/screen/login/login_view.dart';
import 'package:whilabel_renewal/screen/my_page/setting_view/setting_view.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_view.dart';
import 'package:whilabel_renewal/screen/resign/resign_view.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view_model.dart';

import 'sub_widget/mock_post.dart';

/** 개발할때 사용할 임시 Home view */
class MockHomeView extends ConsumerWidget {
  MockHomeView({Key? key}) : super(key: key);

  final _provider = MockHomeViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(_provider).posts;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: LoadingView(
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                SizedBox(height: 30),
                for (MockArchivingPost post in posts)
                  ColoredBox(
                    color: Colors.black,
                    child: MockPost(archivingPost: post),
                  ),
                TextButton(
                    onPressed: () {
                      ref.read(loadingViewModelProvider.notifier).hideLoading();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingView()));
                    },
                    child: Text("setting view")),
                SizedBox(height: 30),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: Text("loginView")),
                SizedBox(height: 30),
                TextButton(
                    onPressed: () {
                      ref.read(loadingViewModelProvider.notifier).showLoading();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResignView()));
                    },
                    child: Text("resignView")),
                SizedBox(height: 30),
                TextButton(
                    onPressed: () {
                      ref.read(loadingViewModelProvider.notifier).showLoading();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnBoardingView()));
                    },
                    child: Text("onboarding")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
