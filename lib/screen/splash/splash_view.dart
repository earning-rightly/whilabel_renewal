

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/screen/splash/splash_view_model.dart';

import '../../design_guide_managers/svg_icon_path.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {

  final _viewModel = SplashViewModel();


  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      ref.read(_viewModel.provider.notifier).checkAutoLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(_viewModel.provider.notifier).setBuildContext(context);
    return Container(
      color: Colors.black,
      child: Center(
        child: SvgPicture.asset("assets/logo/Whilabel.svg", width: 200, fit: BoxFit.cover),
      ),
    );
  }
}
