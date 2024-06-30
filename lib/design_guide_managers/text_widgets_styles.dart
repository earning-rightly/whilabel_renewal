import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';


InputDecoration createLargeTextFieldStyle(
    String hinText,
    ) {
  const double RADIUS = 8;
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(RADIUS)),
      borderSide: const BorderSide(
        color: ColorsManager.black400,
        width: 1,
      ),
    ),
    // 활성화 되기전 스타일
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(RADIUS)),
      borderSide: const BorderSide(
        color: ColorsManager.black400,
        width: 1,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(RADIUS)),
      borderSide: const BorderSide(
        color: ColorsManager.gray300,
        width: 1,
      ),
    ),
    // 활성화 스타일
    contentPadding:
    const EdgeInsets.only(top: 10, bottom: 12, left: 12, right: 12),
    focusColor: ColorsManager.yellow,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(RADIUS)),
      borderSide: const BorderSide(color: ColorsManager.gray500, width: 2),
    ),
  );
}
