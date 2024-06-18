import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/login/login_view.dart';
import 'package:whilabel_renewal/screen/my_page/my_page_view.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_view.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view_model.dart';

/** 개발할때 사용할 임시 Home view */
class MockHomeView extends ConsumerWidget {
  const MockHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                SizedBox(height: 30),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: Text("loginView")),
                SizedBox(height: 30),
                SizedBox(height: 30),
                TextButton(
                    onPressed: () {
                      ref.read(loadingViewModelProvider.notifier).showLoading();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OnBoardingView()));
                    },
                    child: Text("onboarding")),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyPageView()));
                    },
                    child: Text("myPageView")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
