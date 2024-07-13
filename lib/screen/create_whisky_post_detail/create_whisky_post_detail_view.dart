import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_widgets_styles.dart';
import 'package:whilabel_renewal/screen/camera/camera_view_model.dart';
import 'package:whilabel_renewal/screen/common_views/star_rating.dart';
import 'package:whilabel_renewal/screen/common_views/taste_range.dart';
import 'package:whilabel_renewal/screen/common_views/text_field_lengh_counter.dart';
import 'package:whilabel_renewal/screen/create_whisky_post_detail/page/post_success_page.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_page.dart';
import 'package:whilabel_renewal/singleton/user_singleton.dart';

import './sub_widget/create_whisky_post_detail_footer.dart';
import 'create_whisky_post_detail_view_model.dart';

/** 개발할때 사용할 임시 Home view */
class CreateWhiskyPostDetailView extends ConsumerWidget {
  final File currentFile;

  CreateWhiskyPostDetailView({
    Key? key,
    required this.currentFile,
  }) : super(key: key);

  final String whiskyName = "mockWhisy";
  final double strength = 45;
  final String distilleryName = "mock distillery";
  final String distilleryLocation = "스코드 ";

  final _provider = CreateWhiskyPostDetailViewModel().provider;
  final tasteNoteController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final features = ref.watch(_provider).tasteFeatures;
    double starScore = ref.watch(_provider).starScore;
    final viewModel = ref.watch(_provider.notifier);
    final whiskyInfo = ref.watch(cameraProvider).scanResult;

    ref.listen(_provider, (previousState, newState) {
      if (newState.isPostSuccess == true) {
        /*TODO 포스트 생성을 완료하면 WhiskyPostDetailView()로
        * 이동 할 수 있게 API에서 새로 생성된 post의 id를 주자
        * **/
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainBottomTabPage()),
        );
      }
    });

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
                height: MediaQuery.of(context).size.height * 1.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 120.h,
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
                            initialRating: starScore,
                            disable: false,
                            itemSize: 42,
                            onRatingUpdate: (double score) {
                              viewModel.onChangeStarScore(score);
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
                          onChanged: (text) {
                            viewModel.onChangeNote(text);
                          },
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
                                    title: tasteFeature.title.displayName,
                                    subTitleRight: tasteFeature.highExpression,
                                    subTitleLeft: tasteFeature.lowExpression,
                                    value: tasteFeature.value,
                                    size: flavorRangeSize,
                                    disable: false,
                                    onChangeRating: (int value) async {
                                      viewModel.onChangeTasteFeature(
                                          tasteFeature.title, value);
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
          Positioned(
              bottom: 0,
              child: CreateArchivingPostFooter(
                currentFile: currentFile,
                whiskyName: whiskyInfo?.whiskyName ?? whiskyName,
                strength: whiskyInfo?.distilleryRating ?? strength,
                distilleryCountry:
                    whiskyInfo?.distilleryCountry ?? distilleryName,
                distilleryAddress:
                    whiskyInfo?.distilleryAddress ?? distilleryLocation,
                onPressedEvent: () async {
                  /*TODO 이미지 URL을 실제 URL로 변경하자**/
                  final isResult = await viewModel.savePost(
                      whiskyInfo?.whiskyId ?? 1,
                      "https://fastly.picsum.photos/id/788/200/300.jpg?hmac=86XnLHCHcI7HWgr9Y662VsXxUxs7H70DjGHc_6iaIw4");
                  final int? currentWhiskyCount =
                      await UserSingleton.instance.getUserMeWhiskyCount();
                  if (isResult) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostSuccessPage(
                                currentWhiskyCount: currentWhiskyCount ?? 0)),
                        (Route<dynamic> route) => false);
                  }
                },
              ))
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
