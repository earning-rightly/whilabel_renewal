import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/base_design_settings.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

import './resign_view_model.dart';

class ResignView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resignViewModelProvider);


    return Scaffold(
      appBar: _scaffoldAppBar(context),
      backgroundColor: ColorsManager.black100,
      body: Padding(
        padding: BasePadding.basicPadding,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: BaseSpacing.space8),

                  // 상단 굵은 탈퇴 안내글
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Flexible(
                      child: Text(
                        softWrap: true,
                        state.resignViewText.mainCautionText,
                        style: TextStylesManager.bold20,
                        maxLines: 3,
                      ),
                    )
                  ]),
                  SizedBox(height: BaseSpacing.space24),

                  // 첫 번째 리스트 글
                  _createWarningText(state.resignViewText.cautionContentTextOne),
                  SizedBox(height: BaseSpacing.space12),

                  // 두 번째 리스트 글
                  _createWarningText(state.resignViewText.cautionContentTextTwo),
                  SizedBox(height: BaseSpacing.space12),

                  // 세 번째 리스트 글
                  _createWarningText(state.resignViewText.cautionContentTextThree, maxLine: 2),

                  const Spacer(),

                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                        color: ColorsManager.orange,
                        borderRadius: BorderRadius.all(
                            Radius.circular(BaseRadius.radius12))),
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "위라벨 계속 사용하기",
                          style: TextStyle(color: ColorsManager.gray500),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          ref.read(resignViewModelProvider.notifier).showResignConfirmPopUp(context);
                        },
                        child: const Text(
                          "탈퇴하기",
                          style: TextStyle(color: ColorsManager.gray200),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                ],
              ),
            ],
          ),
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
      title: const Text(
        "탈퇴하기",
        style: TextStylesManager.bold16,
      ),
    );
  }

  Widget _createWarningText(String text, {int maxLine = 1}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("\u2022\t\t", style: TextStylesManager.regular14),
      Flexible(
        child: Text(
          text,
          style: TextStylesManager.regular14,
          maxLines: maxLine,
        ),
      )
    ]);
  }
}
