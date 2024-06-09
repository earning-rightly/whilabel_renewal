import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';


/*홈, 디테일, 위스키 평가 초기 화면에서 사용합니다. */
Widget buildWhilabelDivider({Color? color, double? thickness}){

   return Divider(
   color: color ?? ColorsManager.black200,
   thickness: thickness ?? 2,
   );

 }