import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/common_views/function/divider.dart';
import 'package:whilabel_renewal/screen/route/routes.dart';

import '../../design_guide_managers/svg_icon_path.dart';
import './sub_widget/modify_button.dart';
import './whisky_post_detail_view_model.dart';
import 'whisky_post_detail_state.dart';
import 'sub_widget/user_critique_container/user_critique_container.dart';
import 'sub_widget/user_critique_container/user_critique_container_view_model.dart';

class WhiskyPostDetailView extends ConsumerStatefulWidget {
  const WhiskyPostDetailView({super.key, required this.postId});

  final int postId;

  @override
  ConsumerState<WhiskyPostDetailView> createState() =>
      _WhiskyPostDetailViewState(postId: postId);
}

class _WhiskyPostDetailViewState extends ConsumerState<WhiskyPostDetailView> {
  final tasteNoteController = TextEditingController();
  final userCritiqueViewModel = UserCritiqueContainerViewModel();
  final _viewModel = WhiskyPostDetailViewModel();
  final postId;

  _WhiskyPostDetailViewState({
    required this.postId,
  });

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_viewModel.provider.notifier).init(postId);
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(_viewModel.provider);
    bool isModify = state.isModify;
    final userCritiqueContainerViewModel =
        ref.read(userCritiqueViewModel.provider.notifier);
    final Size size = MediaQuery.of(context).size;
    final data = state.data;

    return Scaffold(
      backgroundColor: ColorsManager.black100,
      body: SafeArea(
        child: SizedBox(
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
                          child: CachedNetworkImage(
                            imageUrl: data?.distilleryImage ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                            ref
                                                .read(
                                                _viewModel.provider.notifier)
                                                .getWhiskyName(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStylesManager.bold20),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        buildDistilleryAndStrengthText(
                                            ref
                                                .read(
                                                _viewModel.provider.notifier)
                                                .getDistilleryAddressAndCountry(),
                                            (data?.distilleryRating ?? 0)
                                                .toString())
                                      ],
                                    ),
                                  ),
                                  const Expanded(flex: 106, child: SizedBox())
                                ],
                              ),
                              const SizedBox(height: 12),
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
                                          isModify: isModify,
                                          onClickButton: () async {
                                            //TODO 저장을 누르면 viewSate에 방영 & dialog 출력
                                            if (isModify) {
                                              // 저장 버튼 눌렀을 떄
                                              ref
                                                  .read(_viewModel
                                                  .provider.notifier)
                                                  .processWhiskyPostUpdate(
                                                  userCritiqueContainerViewModel,
                                                  tasteNoteController.text);
                                            } else {
                                              // 수정 버튼 눌렀을 떄
                                              tasteNoteController.text =
                                                  data?.tasteNote ?? "";
                                              userCritiqueContainerViewModel
                                                  .setState(
                                                  note: data?.tasteNote ?? "",
                                                  starScore:
                                                  data?.starRating ?? 0,
                                                  features:
                                                  state.tasteFeatures);
                                            }
                                            ref
                                                .read(
                                                _viewModel.provider.notifier)
                                                .setIsModifyState(!isModify);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${ref.read(_viewModel.provider.notifier).formatDate(state.data?.modifyDateTime ?? (state.data?.createDateTime ?? "2000-01-01"))}\t작성",
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
                                starScore: data?.starRating ?? 0,
                                isModify: isModify,
                                tasteNoteController: tasteNoteController,
                                note: data?.tasteNote ?? "",
                                features: state.tasteFeatures,
                                viewModel: userCritiqueContainerViewModel,
                              ),
                              // BasicDivider(),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 24),
                                    // BasicDivider(),
                                    Container(
                                      height: 4,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 24),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    //상단 앱바
                    Container(
                      alignment: Alignment.topCenter,
                      height: 30,
                      margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorsManager.black400,
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  bool isAblePop = Navigator.canPop(context);
                                  if (isAblePop)   Navigator.pop(context);
                                  else{
                                    Navigator.pushReplacementNamed(context, Routes.main_tab);
                                  }
                                },
                                icon: SvgPicture.asset(SvgIconPath.backBold)),
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDistilleryAndStrengthText(String distillery, String strength) {
    const dot = "\t\u2022\t";
    final text;
    if (distillery.isEmpty && strength.isEmpty) {
      text = "위스키 정보 검토중";
    } else {
      text = "$distillery$dot$strength%";
    }
    return Text(text,
        maxLines: 2,
        style: TextStylesManager.createHadColorTextStyle("R14", Colors.grey));
  }
}
