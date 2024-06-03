import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../design_guide_managers/base_design_settings.dart';
import '../../../design_guide_managers/color_manager.dart';
import '../../../design_guide_managers/svg_icon_path.dart';

class RegisterUserInfoView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _scaffoldAppBar(context),
      backgroundColor: ColorsManager.black100,
      body: Padding(
        padding: BasePadding.basicPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "dldldldl",

            )
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
        icon: SvgPicture.asset(SvgIconPath.backBold),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
