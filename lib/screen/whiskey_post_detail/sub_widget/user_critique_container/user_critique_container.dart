import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/common_views/star_rating.dart';
import 'package:whilabel_renewal/screen/common_views/taste_range.dart';
import 'package:whilabel_renewal/screen/common_views/text_field_lengh_counter.dart';

import './user_critique_container_view_model.dart';

class UserCritiqueContainer extends ConsumerWidget {
  final bool isModify;
  final double starScore;
  final List<TasteFeature> features;
  final TextEditingController tasteNoteController;
  final String note;
  final UserCritiqueContainerViewModel viewModel ;


  const UserCritiqueContainer(
      {Key? key,
      required this.isModify,
      required this.starScore,
      required this.tasteNoteController,
      required this.features,
      required this.note,
      required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isModify ? ColorsManager.black200 : ColorsManager.black200,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: isModify
              ? Border.all(width: 2, color: ColorsManager.orange)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 별점
            const Text("별점", style: TextStylesManager.bold14),
            // const SizedBox(height: 8),
            _createEmptySpace(8),
            StarRating(
              initialRating: starScore,
              disable: !isModify,
              onRatingUpdate: (double score) {
                viewModel.onChangeStarScore(score);
              },
            ),
            _createEmptySpace(24),

            // 테이스팅 노트
            const Text("테이스팅 노트", style: TextStylesManager.bold14),
            const SizedBox(height: 8),
            if (isModify)
              TextFormField(
                decoration: createLargeTextFieldStyle("당신의 의견을 기다릴게요"),
                // initialValue: tasteNoteController,
                controller: tasteNoteController,
                maxLines: 7,
                style: TextStylesManager.regular16,
                maxLength: 1000,
                buildCounter: (
                  _, {
                  required currentLength,
                  maxLength,
                  required isFocused,
                }) =>
                    TextFieldLengthCounter(
                  currentLength: currentLength,
                  maxLength: maxLength!,
                ),
                onChanged: (text) {},
              )
            else
              Text(note,
                  style: TextStylesManager.createHadColorTextStyle(
                      "R16", ColorsManager.gray200)),

            _createEmptySpace(24),
            // 맛 평가
            const Text("맛 평가", style: TextStylesManager.bold14),
            _createEmptySpace(16),
            Container(
                decoration: const BoxDecoration(
                  color: ColorsManager.black100,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  final flavorRangeSize = (constraints.maxWidth - 16) / 5;
                  return Column(
                    children: [
                      for (TasteFeature tasteFeature in features)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TasteRange(
                            title: tasteFeature.title,
                            subTitleRight: tasteFeature.highExpression,
                            subTitleLeft: tasteFeature.lowExpression,
                            value: tasteFeature.value,
                            size: flavorRangeSize,
                            onChangeRating: (int value) async {
                              viewModel.onChangeTasteFeature(
                                  tasteFeature.title, value);
                            },
                          ),
                        )
                    ],
                  );
                }))
          ],
        ));
  }

  Widget _createEmptySpace(double height) {
    return SizedBox(height: height);
  }

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
}
