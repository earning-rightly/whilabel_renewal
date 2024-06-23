import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/base_design_settings.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_view_model.dart';
import 'package:whilabel_renewal/screen/onboarding/sub_widget/rounded_progressbar.dart';

import '../../design_guide_managers/text_style_manager.dart';

class OnBoardingView extends ConsumerWidget {
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_viewModel.provider);
    ref.read(_viewModel.provider.notifier).setBuildContext(context);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xffA87137),
                Color(0xff864E33),
              ]),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 40,
                    width: 300,
                    child: RoundedProgressbar(target: state.target),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  state.title,
                  style: TextStylesManager.bold24,
                ),
                const Spacer(flex: 1),
                GestureDetector(
                  onTap: () {
                    ref.read(_viewModel.provider.notifier).btnTapped();
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(BaseRadius.radius12))),
                    child: Center(
                      child: Text(
                        state.btnTitle,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.brown100),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 34),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
