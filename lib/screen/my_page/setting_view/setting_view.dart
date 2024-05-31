import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'setting_view_model.dart';

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*TODO viewModel이라는 변수명 말고 어떤 것이 좋을까?**/
    final viewModel = ref.read(settingViewProvider.notifier);
    final viewText = ref.watch(settingViewProvider).settingViewText;
    final Size size = MediaQuery.of(context).size;

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
                        isButtonState: false,
                        onPressedButton: () {
                          viewModel.updatePushAlimState(true);
                        }),
                    ToggleSwitchButton(
                      title: viewText.marketingAlimText,
                      isButtonState: true,
                      onPressedButton: () {},
                    ),
                  ],
                ),
                SizedBox(
                  // alignment: Alignment.centerLeft,
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
                        onPressed: () {},
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

class ToggleSwitchButton extends StatefulWidget {
  ToggleSwitchButton(
      {Key? key,
      required this.title,
      required this.isButtonState,
      required this.onPressedButton})
      : super(key: key);
  final Function onPressedButton;
  final String title;
  final bool isButtonState;

  @override
  State<ToggleSwitchButton> createState() => _ToggleSwitchButtonState();
}

class _ToggleSwitchButtonState extends State<ToggleSwitchButton> {
  /*TODO) 버튼 상태를 받아 부모에게 받아와서 상태를 변화 시켜주자 **/

  bool isButtonState = false;
  String offToggleIconPath = "assets/icon/toggle_off.svg";
  String onToggleIconPath = "assets/icon/toggle_on.svg";

  @override
  void initState() {
    isButtonState = widget.isButtonState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title,
              style: TextStylesManager.createHadColorTextStyle(
                "M16",
                ColorsManager.gray200,
              )),
          IconButton(
            iconSize: 60,
            onPressed: () {
              widget.onPressedButton();
              setState(() {
                isButtonState = !isButtonState;
              });
            },
            icon: SvgPicture.asset(
                isButtonState == true ? onToggleIconPath : offToggleIconPath),
          )
        ],
      ),
    );
  }
}
