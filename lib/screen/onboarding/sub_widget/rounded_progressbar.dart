import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';

class RoundedProgressbar extends ConsumerWidget {
  final num target;

  RoundedProgressbar({
    required this.target,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (_, constraints) {
      final x = constraints.maxWidth;
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: x,
            height: 10,
            decoration: BoxDecoration(
                color: Color.fromRGBO(245, 245, 245, 0.2),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: (target * x),
            height: 10,
            decoration: BoxDecoration(
                color: ColorsManager.white,
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ],
      );
    });
  }
}
