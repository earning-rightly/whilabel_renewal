import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/my_page/announcement/sub_widget/announcement_item.dart';

import 'announcement_view_model.dart';
import 'sub_widget/empty_announcement_body.dart';

class AnnouncementView extends ConsumerWidget {
  AnnouncementView({Key? key}) : super(key: key);

 final _provider = AnnouncementViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final announcements = [];
    final viewText = ref.watch(_provider).viewText;


    return Scaffold(
        appBar: _buildScaffoldAppBar(context, SvgIconPath.backBold, viewText.pageTitle, onPop: (){}),

        body: SafeArea(
      child: (announcements == null || announcements.isEmpty)
          ? EmptyAnnouncementBody()
          : ListView.separated(
              padding: EdgeInsets.only(top: 10, left: 16, right: 16),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                return AnnouncementItem(
                  title: announcements[index].title,
                  body: announcements[index].body,
                  whiskyName: announcements[index].whiskyName,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(color: ColorsManager.black200);
              }),
    ));
  }
 AppBar _buildScaffoldAppBar(BuildContext context, String svgPath, String title,{Function()? onPop}) {
   return AppBar(
     toolbarHeight: 50,
     centerTitle: true,
     leading: IconButton(
       padding: EdgeInsets.only(left: 16),
       alignment: Alignment.centerLeft,
       icon: SvgPicture.asset(svgPath),
       onPressed: () {
         Navigator.pop(context);
         if (onPop != null) onPop();
       },
     ),
     title: Text(
       title,
       style: TextStylesManager.bold16,
     ),
   );
 }
}
