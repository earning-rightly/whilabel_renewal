import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

// 일열로 세워진 5개의 box에 채워짐 갯 수에 따라서 왼쪽과 오른쪽에
// 어느쪽에 치우쳐 져있는지 알 수 있습니다.

class TasteRange extends StatefulWidget {
  final String title; // 무엇에 관한
  final String subTitleRight;
  final String subTitleLeft;
  final int value;
  final double? size;
  final bool? disable;
  final Function(int rating)? onChangeRating;

  TasteRange({
    Key? key,
    required this.title,
    required this.subTitleRight,
    required this.subTitleLeft,
    required this.value,
    this.size,
    this.disable = false,
    this.onChangeRating,
  }) : super(key: key);

  @override
  State<TasteRange> createState() => _TasteRangeState();
}

class _TasteRangeState extends State<TasteRange> {
  final maxCount = 5;
  double filledCount = 0;

  @override
  Widget build(BuildContext context) {
    // 채우는 값이 잘못들어오면 빈박스 반환
    if (widget.value < 0 || widget.value > maxCount) {
      return SizedBox();
    }

    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                createFlaverRating(widget.value.toDouble(), widget.disable!,
                    size: widget.size ??
                        (MediaQuery.of(context).size.width - 32 - 12) / 5),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            widget.title,
            style: TextStylesManager.bold14,
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          child: Text(
            widget.subTitleLeft,
            style: filledCount < maxCount / 2
                ? TextStylesManager.createHadColorTextStyle(
                    "B14", ColorsManager.yellow)
                : TextStylesManager.createHadColorTextStyle(
                    "B14", ColorsManager.gray200),
          ),
        ),
        Positioned(
          top: 50,
          right: 0,
          child: Text(
            widget.subTitleRight,
            style: (filledCount > maxCount / 2)
                ? TextStylesManager.createHadColorTextStyle(
                    "B14", ColorsManager.yellow)
                : TextStylesManager.createHadColorTextStyle(
                    "B14", ColorsManager.gray200),
          ),
        )
      ],
    );
  }

  Widget createFlaverRating(double initialRating, bool disable,
      {onRatingUpdate, double size = 67}) {
    return RatingBar.builder(
        ignoreGestures: disable,
        // 맛을 매길것 인지 보기만 할 것인지
        initialRating: initialRating,
        // 처음에 보여 줘야 할 맛 개수
        minRating: 0,
        itemCount: 5,
        itemSize: size,
        direction: Axis.horizontal,
        itemPadding: EdgeInsets.only(top: 0, bottom: 0, right: 2),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return buildTasteBox(
                leftRadius: 8,
                rightRadius: 0,
              );
            case 1:
              return buildTasteBox(
                leftRadius: 0,
                rightRadius: 0,
              );

            case 2:
              return buildTasteBox(
                leftRadius: 0,
                rightRadius: 0,
              );

            case 3:
              return buildTasteBox(
                leftRadius: 0,
                rightRadius: 0,
              );

            case 4:
              return buildTasteBox(
                leftRadius: 0,
                rightRadius: 8,
              );
          }

          return Icon(Icons.access_alarm_rounded);
        },
        unratedColor: ColorsManager.black300,
        onRatingUpdate: widget.onChangeRating == null
            ? (rating) {
                print("onChangeRating null");

                setState(() {
                  filledCount = rating;
                });
              }
            : (rating) {
                setState(() {
                  filledCount = rating;
                });
                widget.onChangeRating!(rating.toInt());
              });
  }

  Widget buildTasteBox({
    required double leftRadius,
    required double rightRadius,
  }) {
    return Container(
      width: 67,
      height: 16,
      decoration: BoxDecoration(
        color: ColorsManager.yellow,
        border: Border.all(width: 1), // const르 둘 수 없기에 final

        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(leftRadius),
          right: Radius.circular(rightRadius),
        ),
      ),
    );
  }
}
