import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/my_page/announcement/announcement_view_model.dart';

// ignore: must_be_immutable
class EmptyAnnouncementBody extends ConsumerWidget {
  EmptyAnnouncementBody({super.key});

  // String announcementPageTitle = "아직 알림이 없어요";
  // String announcementPageSubText = "새로운 알림이 오면 알려들릴게요";
  // final provider = Ann().provider;

  final _provider = AnnouncementViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewText = ref.watch(_provider).viewText;

    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 4,
            left: 0,
            right: 0,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIconPath.notification,
                    height: 50,
                    colorFilter: ColorFilter.mode(
                        ColorsManager.black300, BlendMode.srcIn),
                  ),
                  SizedBox(height: 24),
                  Text(
                    viewText.emptyAnnouncementBodyIntroduce,
                    maxLines: 2,
                    style: TextStylesManager.bold20,
                  ),
                  SizedBox(height: 12),
                  Text(
                    viewText.emptyAnnouncementServiceText,
                    maxLines: 2,
                    style: TextStylesManager.createHadColorTextStyle(
                        "R16", ColorsManager.gray),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}