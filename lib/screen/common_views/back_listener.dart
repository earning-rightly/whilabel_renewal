import 'dart:io';

import 'package:flutter/material.dart';

class BackListener extends StatelessWidget {
  const BackListener(
      {Key? key, required this.child, required this.onBackButtonClick})
      : super(key: key);
  final Function() onBackButtonClick;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 50 && Platform.isIOS)
            onBackButtonClick();
        },
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool result) async {
            if (Platform.isAndroid) onBackButtonClick();
          },
          child: child,
        ));
  }
}
