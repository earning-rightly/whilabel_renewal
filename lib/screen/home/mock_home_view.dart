import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whilabel_renewal/screen/camera/camera_view.dart';
import 'package:whilabel_renewal/screen/create_whisky_post_detail/create_whisky_post_detail_view.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';
import 'package:whilabel_renewal/screen/login/login_view.dart';
import 'package:whilabel_renewal/screen/my_page/my_page_view.dart';
import 'package:whilabel_renewal/screen/my_page/pages/resign/resign_view.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view_model.dart';


/** 개발할때 사용할 임시 Home view */
class MockHomeView extends ConsumerWidget {
  MockHomeView({Key? key}) : super(key: key);

  final _provider = MockHomeViewModel().provider;

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

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
                              builder: (context) => ResignView()));
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
                TextButton(onPressed: () async{
                  final image = await getImageFileFromAssets("mock/mock_whisky.jpg");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateWhiskyPostDetailView(currentFile: image,)));

                }, child: Text("createPostView"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
