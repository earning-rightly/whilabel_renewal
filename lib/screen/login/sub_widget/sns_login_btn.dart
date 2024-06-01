import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/base_design_settings.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

class SNSLoginBtn extends ConsumerWidget {

  final Function()? onPressed;
  final String iconPath;
  final String title;


  SNSLoginBtn({required this.onPressed, required this.iconPath, required this.title});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 52,
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(BaseRadius.radius16)),
          color: Colors.white,
          child:  InkWell(
              onTap: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 4),
                  Text(title,
                      style: TextStylesManager.createHadColorTextStyle(
                          "B16", ColorsManager.black100))
                ],
              )
          ),
        )
    );
  }
}