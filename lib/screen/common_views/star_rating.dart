import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';


class StarRating extends StatelessWidget {
 final double initialRating;
 final bool disable;
 final double itemSize;
  final Function(double rating)? onRatingUpdate;
  const StarRating({Key? key, required this.initialRating, required this.disable, this.onRatingUpdate, this.itemSize=32}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  RatingBar.builder(
        ignoreGestures: disable, // 별점 매길 것 인지 보기만 할 것인지
        initialRating: initialRating, // 처음에 보여 줘야 할 별점 개수

        itemSize: itemSize,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.only(right: 12),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: ColorsManager.yellow,
        ),
        unratedColor: ColorsManager.black300,
        onRatingUpdate: onRatingUpdate != null
            ? (rating) => onRatingUpdate!(rating)
            : (rating) => rating);
  }
}
