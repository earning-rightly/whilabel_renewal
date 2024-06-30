import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/screen/camera/camera_view.dart';
import 'package:whilabel_renewal/screen/create_archiving_post/create_archiving_post_view.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';
import 'package:whilabel_renewal/screen/login/login_view.dart';
import 'package:whilabel_renewal/screen/main/main_page.dart';
import 'package:whilabel_renewal/screen/my_page/my_page_view.dart';
import 'package:whilabel_renewal/screen/my_page/pages/resign/resign_view.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_view.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view_model.dart';

import '../main_bottom_tab_page/main_bottom_tab_page.dart';

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
                              builder: (context) => MainBottomTabPage()));
                    },
                    child: Text("onboarding")),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPageView()));
                    },
                    child: Text("myPage")),
                TextButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraView()));

                }, child: Text("cameraView")),
                TextButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateArchivingPostView()));

                }, child: Text("createPostView"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
