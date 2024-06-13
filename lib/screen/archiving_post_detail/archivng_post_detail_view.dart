import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/common_views/function/divider.dart';



import './sub_widget/modify_button.dart';
import './archiving_post_detail_view_model.dart';
import 'sub_widget/user_critique_container/user_critique_container.dart';
import 'sub_widget/user_critique_container/user_critique_container_view_model.dart';

class ArchivingPostDetailView extends ConsumerWidget {
  ArchivingPostDetailView({Key? key}) : super(key: key);

  final distilleryImage =
      "https://firebasestorage.googleapis.com/v0/b/whilabel.appspot.com/o/distillery_images%2FAngel_senvy.jpeg?alt=media&token=8aafe5f3-8f39-4a3e-844e-0de50eae52c7";
  final tasteNoteController = TextEditingController();

  final viewModel = ArchivingPostDetailViewModel();
  final userCritiqueViewModel = UserCritiqueContainerViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(viewModel.provider);
    final userCriqueContainerViewModel =
        ref.watch(userCritiqueViewModel.provider.notifier);
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
                        child: distilleryImage == null
                            ? null
                            : Image.network(
                                distilleryImage,
                                fit: BoxFit.fill,
                                frameBuilder: (BuildContext context,
                                    Widget child,
                                    int? frame,
                                    bool wasSynchronouslyLoaded) {
                                  if (wasSynchronouslyLoaded) {
                                    return child;
                                  }
                                  return AnimatedOpacity(
                                    opacity: frame == null ? 0 : 1,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeOut,
                                    alwaysIncludeSemantics: true,
                                    child: child,
                                  );
                                },
                              ),
                      ),
                      SizedBox(height: 20),
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
                                          state.texts.whiskeyName != ""
                                              ? state.texts.whiskeyName
                                              : "위스키를 등록 중입니다",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStylesManager.bold20),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      buildDistilleryAndStrengthText(
                                          texts.distillery, texts.strength)
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
                                        state.texts.myEvaluationText,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStylesManager.bold18,
                                      ),
                                      ModifyButton(
                                        isModify: state.isModify,
                                        onClickButton: () async {
                                          //TODO 저장을 누르면 viewSate에 방영 & dialog 출력
                                          if (state.isModify) {
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
                                                features,ref);
                                          } else {
                                            // 수정 버튼 눌렀을 떄
                                            tasteNoteController.text =
                                                state.note;
                                            userCriqueContainerViewModel
                                                .setState(
                                                    note: state.note,
                                                    starScore: state.starScore,
                                                    features:
                                                        state.tasteFeatures);
                                          }
                                          viewModel
                                              .setIsModifyState(state.isModify);
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    state.texts.createAt + "\t작성",
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
                              starScore: state.starScore,
                              isModify: state.isModify,
                              tasteNoteController: tasteNoteController,
                              note: state.note,
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
    const dot = "\u2022\t\t";
    if (distillery.isNotEmpty && strength.isNotEmpty) {
      return Row(children: [
        distillery.isNotEmpty
            ? Text(
                "$distillery",
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
