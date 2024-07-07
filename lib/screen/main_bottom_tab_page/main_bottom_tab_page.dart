import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/camera/camera_view.dart';
import 'package:whilabel_renewal/screen/main/main_page.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_view_model.dart';
import 'package:whilabel_renewal/screen/my_page/my_page_view.dart';

import '../../design_guide_managers/svg_icon_path.dart';

class MainBottomTabPage extends ConsumerWidget {
  final _viewModel = MainBottomTabViewModel();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_viewModel.provider);

    return Scaffold(
      body: IndexedStack(
        index: state.currentIndex,
        children: [MainPage(),CameraView() ,MyPageView()],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 4, bottom: 0, right: 4, left: 4),
        decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: ColorsManager.black300, width: 1.0)),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          backgroundColor: ColorsManager.black100,
          currentIndex: state.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorsManager.brown100,
          unselectedItemColor: ColorsManager.black300,
          iconSize: 24,
          onTap: (index) {
            ref.read(_viewModel.provider.notifier).setCurrentIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                SvgIconPath.whisky,
                colorFilter: const ColorFilter.mode(
                    ColorsManager.black300, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                SvgIconPath.whisky,
                colorFilter: const ColorFilter.mode(
                    ColorsManager.brown100, BlendMode.srcIn),
              ),
              label: "main"
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  SvgIconPath.camera,
                  colorFilter: const ColorFilter.mode(
                      ColorsManager.black300, BlendMode.srcIn),
                ),
                activeIcon: SvgPicture.asset(
                  SvgIconPath.camera,
                  colorFilter: const ColorFilter.mode(
                      ColorsManager.brown100, BlendMode.srcIn),
                ),
                label: "camera"
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                SvgIconPath.user,
                colorFilter: const ColorFilter.mode(
                    ColorsManager.black300, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                SvgIconPath.user,
                colorFilter: const ColorFilter.mode(
                    ColorsManager.brown100, BlendMode.srcIn),
              ),
              label: "mypage"
            ),
          ],
        ),
      ),
    );
  }
}
