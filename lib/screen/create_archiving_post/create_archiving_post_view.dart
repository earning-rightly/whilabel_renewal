import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_widgets_styles.dart';
import 'package:whilabel_renewal/screen/common_views/star_rating.dart';
import 'package:whilabel_renewal/screen/common_views/taste_range.dart';
import 'package:whilabel_renewal/screen/common_views/text_field_lengh_counter.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';

/** 개발할때 사용할 임시 Home view */
class CreateArchivingPostView extends ConsumerWidget {
  CreateArchivingPostView({Key? key}) : super(key: key);

  final _provider = MockHomeViewModel().provider;
  final tasteNoteController = TextEditingController();
  final List<TasteFeature> features = [
    TasteFeature(
      title: "맛",
      value: 3,
      lowExpression: "별로",
      highExpression: "최고",
    ),
    TasteFeature(
      title: "맛",
      value: 3,
      lowExpression: "별로",
      highExpression: "최고",
    ),
    TasteFeature(
      title: "맛",
      value: 3,
      lowExpression: "별로",
      highExpression: "최고",
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(_provider).posts;
    final Size size = MediaQuery.of(context).size;
    const double initalStarValue = 0;
    return Scaffold(
      appBar: _createAppBar(context, "나의 평가"),
      body: SafeArea(
        child: Stack(clipBehavior: Clip.none, children: [
          Builder(builder: (context) {
            // final viewModel = context.watch<WhiskyCritiqueViewModel>();
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 1.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("위스키를 평가해주세요", style: TextStylesManager.bold20),
                          _createEmptySpace(),
                          // 별점
                          Text(
                            "탭해서 평가해 주세요 (필수)",
                            style: TextStylesManager.createHadColorTextStyle(
                                "B14", ColorsManager.gray),
                          ),
                          _createEmptySpace(h: 16),

                          StarRating(
                            initialRating: initalStarValue,
                            disable: false,
                            itemSize: 38,
                            onRatingUpdate: (double score) {
                              // viewModel.onChangeStarScore(score);
                            },
                          ),
                        ],
                      ),
                    ),
                    _createEmptySpace(h: 24),
                    const Divider(color: ColorsManager.black200),
                    _createEmptySpace(h: 24),
                    // 테이스팅 노트
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "테이스팅 노트 (선택)",
                          style: TextStylesManager.bold16,
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          decoration:
                              createLargeTextFieldStyle("당신의 의견을 기다릴게요"),
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
                      ],
                    ),
                    SizedBox(height: (24)),
                    const Divider(
                      color: ColorsManager.black200,
                    ),
                    SizedBox(height: (24)),
                    // 맛 기록
                    Text(
                      "맛 기록 (선택)",
                      style: TextStylesManager.bold16,
                    ),
                    SizedBox(height: 12),
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
                          final flavorRangeSize =
                              (constraints.maxWidth - 16) / 5;
                          return Column(
                            children: [
                              for (TasteFeature tasteFeature in features)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: TasteRange(
                                    title: tasteFeature.title,
                                    subTitleRight: tasteFeature.highExpression,
                                    subTitleLeft: tasteFeature.lowExpression,
                                    value: tasteFeature.value,
                                    size: flavorRangeSize,
                                    disable: false,
                                    onChangeRating: (int value) async {
                                      // viewModel.onChangeTasteFeature(
                                      //     tasteFeature.title, value);
                                    },
                                  ),
                                )
                            ],
                          );
                        }))
                  ],
                ),
              ),
            );
          }),
        ]),
      ),
    );
  }

  AppBar _createAppBar(BuildContext context, String title) {
    return AppBar(
      toolbarHeight: 50,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        padding: EdgeInsets.only(left: 16, right: 16),
        alignment: Alignment.centerLeft,
        icon: SvgPicture.asset(SvgIconPath.close),
        onPressed: () {
          Navigator.pop(context);
          // if (onPop != null) onPop();
        },
      ),
      title: Text(
        title,
        style: TextStylesManager.bold16,
      ),
    );
  }

  Widget _createEmptySpace({double h = 8}) {
    return SizedBox(height: h);
  }
}
