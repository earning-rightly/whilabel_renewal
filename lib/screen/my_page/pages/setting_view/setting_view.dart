import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'setting_view_model.dart';

import './sub_widget/toggle_switch_button.dart';
import '../resign/resign_view.dart';

class SettingView extends ConsumerWidget {
  SettingView({super.key});

  final _viewModel = SettingViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*TODO viewModel이라는 변수명 말고 어떤 것이 좋을까?**/
    final viewModel = ref.read(_viewModel.provider.notifier);
    final viewState = ref.read(_viewModel.provider);
    final viewText = ref.watch(_viewModel.provider).settingViewText;
    ref.read(_viewModel.provider.notifier).setBuildContext(context);
    final Size size = MediaQuery.of(context).size;

    bool pushNotificationState = viewState.isAblePushNotification;
    bool marketingNotificationState = viewState.isAbleMarketingNotification;

    return Scaffold(
      appBar: _scaffoldAppBar(context),
      backgroundColor: ColorsManager.black100,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Column(
                  children: [
                    ToggleSwitchButton(
                        title: viewText.pushAlimText,
                        isButtonState: pushNotificationState,
                        onPressedButton: () {
                          viewModel.updatePushNotificationState(pushNotificationState);
                        }),
                    ToggleSwitchButton(
                      title: viewText.marketingAlimText,
                      isButtonState: marketingNotificationState,
                      onPressedButton: () {
                        viewModel.updateMarketingNotificationState(marketingNotificationState);

                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        child: Text(viewText.logOutText,
                            style: TextStylesManager.createHadColorTextStyle(
                                "R14", ColorsManager.black300)),
                        onPressed: () {
                          viewModel.showPopUp(context);
                        },
                      ),
                      TextButton(
                        child: Text(viewText.signOutText,
                            style: TextStylesManager.createHadColorTextStyle(
                                "R14", ColorsManager.black300)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ResignView()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  AppBar _scaffoldAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      centerTitle: true,
      backgroundColor: ColorsManager.black100,
      shadowColor: Colors.transparent,
      leading: IconButton(
        padding: EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        icon: SvgPicture.asset(
          "assets/icon/_back/back_bold.svg",
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

