import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/enums/gender.dart';
import 'package:whilabel_renewal/screen/register/register_user_info/register_user_info_view_model.dart';
import 'package:whilabel_renewal/screen/util_views/date_picker/date_picker_view.dart';
import 'package:whilabel_renewal/screen/util_views/date_picker/date_picker_view_model.dart';

import '../../../design_guide_managers/base_design_settings.dart';
import '../../../design_guide_managers/color_manager.dart';
import '../../../design_guide_managers/svg_icon_path.dart';

class RegisterUserInfoView extends ConsumerWidget {
  final TextEditingController _nicknameController = TextEditingController();
  final DatePickerViewModel _datePickerViewModel = DatePickerViewModel();
  final RegisterUserInfoViewModel _viewModel = RegisterUserInfoViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_viewModel.provider);
    ref.watch(_viewModel.provider.notifier).setContext(context);

    return Scaffold(
      appBar: _scaffoldAppBar(context),
      backgroundColor: ColorsManager.black100,
      body: Padding(
        padding: BasePadding.basicPadding,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.texts.greetingLabel,
                      style: TextStylesManager.bold24,
                    ),
                    const SizedBox(height: 32),
                    Text(state.texts.nameBoxTitle,
                        style: TextStylesManager.bold14),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        hintText: state.texts.nameHint,
                        hintStyle:
                            const TextStyle(color: ColorsManager.gray200),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 1, color: ColorsManager.white),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide:
                              BorderSide(width: 1, color: ColorsManager.red),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      style: const TextStyle(color: ColorsManager.white,fontSize: 15),
                    ),
                    const SizedBox(height: 32),
                    Text(state.texts.genderBoxTitle,
                        style: TextStylesManager.bold14),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(_viewModel.provider.notifier)
                                  .genderBtnTapped(Gender.male);
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: ColorsManager.brown100),
                              fixedSize: const Size(142, 52),
                              backgroundColor: state.gender == Gender.male
                                  ? ColorsManager.brown100
                                  : ColorsManager.black100,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            child: Text(
                              state.texts.maleBtnTitle,
                              style: TextStylesManager.bold16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(_viewModel.provider.notifier)
                                  .genderBtnTapped(Gender.female);
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: ColorsManager.brown100),
                              fixedSize: const Size(142, 52),
                              backgroundColor: state.gender == Gender.female
                                  ? ColorsManager.brown100
                                  : ColorsManager.black100,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            child: Text(
                              state.texts.femaleBtnTitle,
                              style: TextStylesManager.bold16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(state.texts.datePickerBoxTitle,
                        style: TextStylesManager.bold14),
                    const SizedBox(height: 10),
                    DatePickerView(viewModel: _datePickerViewModel),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                final date = ref
                    .read(_datePickerViewModel.provider.notifier)
                    .getResult();

                ref
                    .read(_viewModel.provider.notifier)
                    .registerBtnTapped(_nicknameController.text, date);
              },
              child: Container(
                height: 52,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: ColorsManager.orange,
                    borderRadius: BorderRadius.all(
                        Radius.circular(BaseRadius.radius12))),
                child: Center(
                  child: Text(
                    state.texts.btnTitle,
                    style: const TextStyle(color: ColorsManager.white),
                  ),
                ),
              ),
            ),
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
        alignment: Alignment.centerLeft,
        icon: SvgPicture.asset(SvgIconPath.backBold),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
