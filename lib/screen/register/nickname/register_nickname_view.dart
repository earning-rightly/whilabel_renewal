import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/base_design_settings.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/register/nickname/register_nickname_view_model.dart';

class RegisterNicknameView extends ConsumerWidget {

  final TextEditingController nicknameInputController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerNicknameProvider);

    return Scaffold(
      appBar: _scaffoldAppBar(context),
      backgroundColor: ColorsManager.black100,
      body: Padding(
        padding: BasePadding.basicPadding,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( state.texts.inputformTitleText, style: TextStylesManager.bold24),
            const SizedBox(height: 32),
            TextFormField(
              controller: nicknameInputController,
              decoration: InputDecoration(
                hintText: state.texts.inputHintText,
                hintStyle: const TextStyle(color: ColorsManager.gray200),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1, color: ColorsManager.white),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: ColorsManager.red),
                ),
                errorText: state.errorInfoText,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              style: const TextStyle(color: ColorsManager.white),
              onChanged: (value) {
                ref.read(registerNicknameProvider.notifier).validateNickname(value);
              },
            ),

            const Spacer(flex: 1),

            Container(
              height: 52,
              decoration: BoxDecoration(
                  color: state.nextBtnColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(BaseRadius.radius12))),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    ref.read(registerNicknameProvider.notifier).checkDuplicatedNickname(context, nicknameInputController.text);
                  },
                  child: Text(
                    state.texts.nextBtnTitle,
                    style: TextStyle(color: state.nextBtnTitleColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  AppBar _scaffoldAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      centerTitle: true,
      backgroundColor: ColorsManager.black100,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        icon: SvgPicture.asset(SvgIconPath.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
