import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/screen/common_views/long_text_button.dart';
import 'package:whilabel_renewal/screen/create_whisky_post_detail/create_whisky_post_detail_view.dart';

class ImagePreviewPage extends StatelessWidget {
  const ImagePreviewPage({Key? key, required this.currentFile})
      : super(key: key);
  final File currentFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset(SvgIconPath.backBold),
          ),
        ),
        body: SizedBox(
          child: Column(
            children: [
            SizedBox(height: 74,),
              Expanded(
                child: Image.file(currentFile,
                    fit: BoxFit.fill, width: MediaQuery.of(context).size.width),
              ),
              SizedBox(height: 74,),
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LongTextButton(
                  buttonText: "다음",
                  color: ColorsManager.brown100,
                  onPressedFunc: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateWhiskyPostDetailView(
                          currentFile:  currentFile
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24)
            ],
          ),
        ));
  }
}
