import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/common_views/function/divider.dart';

import './sub_widget/modify_button.dart';
import './whisky_post_detail_view_model.dart';
import 'whisky_post_detail_state.dart';
import 'sub_widget/user_critique_container/user_critique_container.dart';
import 'sub_widget/user_critique_container/user_critique_container_view_model.dart';


class WhiskyPostDetailView extends ConsumerStatefulWidget {
  const WhiskyPostDetailView({super.key});

  @override
  ConsumerState<WhiskyPostDetailView> createState() => _WhiskyPostDetailViewState();
}

class _WhiskyPostDetailViewState extends ConsumerState<WhiskyPostDetailView> {

  final tasteNoteController = TextEditingController();
  final userCritiqueViewModel = UserCritiqueContainerViewModel();
  final _viewModel = WhiskyPostDetailViewModel();

  @override
  Widget build(BuildContext context, ) {
    final state = ref.watch(_viewModel.provider);
    final viewModel = ref.read(_viewModel.provider.notifier);
    bool isModify = state.isModify;
    final userCriqueContainerViewModel =
    ref.read(userCritiqueViewModel.provider.notifier);
    final texts = state.texts;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorsManager.black100,
      body: SizedBox(
        width: size.width,
        height: size.height * 2,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      // 양조장 이미지
                      Container(
                        width: size.width,
                        height: 225,
                        color: ColorsManager.black200,
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: "https://i.imgur.com/CzXTtJV.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 237,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "위스키를 등록 중입니다",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStylesManager.bold20),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      buildDistilleryAndStrengthText(
                                          "texts.distillery", "texts.strength")
                                    ],
                                  ),
                                ),
                                Expanded(flex: 106, child: SizedBox())
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            buildWhilabelDivider(),
                            SizedBox(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "state.texts.myEvaluationText",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStylesManager.bold18,
                                      ),
                                      ModifyButton(
                                        isModify: isModify,
                                        onClickButton: () async {
                                          //TODO 저장을 누르면 viewSate에 방영 & dialog 출력
                                          if (isModify) {
                                            // 저장 버튼 눌렀을 떄
                                            final score =
                                            await userCriqueContainerViewModel
                                                .getStarScore();
                                            final features =
                                            await userCriqueContainerViewModel
                                                .getFeatures();
                                            await viewModel.updatePostInfo(
                                                score,
                                                tasteNoteController.text,
                                                features,
                                                ref);
                                          } else {
                                            // 수정 버튼 눌렀을 떄
                                            tasteNoteController.text =
                                                "state.note";
                                          //   userCriqueContainerViewModel
                                          //       .setState(
                                          //       note: state.note,
                                          //       starScore: state.starScore,
                                          //       features:
                                          //       state.tasteFeatures);
                                          }
                                          // viewModel.setIsModifyState(!isModify);
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "state.texts.createAt" + "\t작성",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStylesManager
                                        .createHadColorTextStyle(
                                        "R14", Colors.grey),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                            UserCritiqueContainer(
                              starScore: 4,
                              isModify: isModify,
                              tasteNoteController: tasteNoteController,
                              note: "state.note",
                              features: state.tasteFeatures,
                              viewModel: userCriqueContainerViewModel,
                            ),
                            // BasicDivider(),
                            Container(
                              width: size.width,
                              padding: const EdgeInsets.only(
                                  top: 10, right: 10, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 24),
                                  // BasicDivider(),
                                  Container(
                                    height: 4,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 24),

                                  Container(
                                    padding: EdgeInsets.all(16),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: ColorsManager.black200,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    child: Column(
                                      children: [
                                        Text(
                                          "맛 특징과 브랜드 특징이",
                                          style: TextStylesManager
                                              .createHadColorTextStyle("R16",
                                              ColorsManager.black400),
                                        ),
                                        Text(
                                          "곧 등록될 예정이에요!",
                                          style: TextStylesManager
                                              .createHadColorTextStyle("R16",
                                              ColorsManager.black400),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // SizedBox(height: 80),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDistilleryAndStrengthText(String distillery, String strength) {
    final state = ref.watch(_viewModel.provider);

    const dot = "\u2022\t\t";
    if (distillery.isNotEmpty && strength.isNotEmpty) {
      return Row(children: [
        distillery.isNotEmpty
            ? Text(
          "$state",
          overflow: TextOverflow.ellipsis,
          style: TextStylesManager.createHadColorTextStyle(
              "R14", Colors.grey),
        )
            : SizedBox(),
        (distillery == false && strength != null)
            ? const Row(
          children: [
            SizedBox(width: 5),
            const Text(dot),
          ],
        )
            : const SizedBox(),
        strength != null
            ? Text(
          "$strength%",
          overflow: TextOverflow.ellipsis,
          style: TextStylesManager.createHadColorTextStyle(
              "R14", Colors.grey),
        )
            : SizedBox(),
      ]);
    } else {
      return Text(
        "위스키 정보 검토중",
        overflow: TextOverflow.ellipsis,
        style: TextStylesManager.createHadColorTextStyle("R14", Colors.grey),
      );
    }
  }
}
