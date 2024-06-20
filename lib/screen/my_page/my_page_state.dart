import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';

part 'my_page_state.freezed.dart';

@freezed
class MyPageState with _$MyPageState {
  const factory MyPageState(
          {
          required String settingIconPath,
          required List<Map<String, dynamic>> myPageViewButtonData,
          required List<Map<String, dynamic>> myPageViewDocButtonData}) =
      _MyPageState;

  factory MyPageState.initial() {
    return MyPageState(
        settingIconPath: SvgIconPath.setting,
        myPageViewButtonData: _myPageViewButtonData,
        myPageViewDocButtonData: _myPageViewDocButtonData);
  }
}

final _myPageViewButtonData = [
  {
    "svg_path": SvgIconPath.announce,
    "title": "공지사항",
    "route": ""
    // "route": Routes.myPageRoutes.announcementRoute
  },
  {
    "svg_path": SvgIconPath.faq,
    "title": "FAQ",
    "route": ""
    // "route": Routes.myPageRoutes.faqRoute,
  },
  {
    "svg_path": SvgIconPath.customer,
    "title": "1:1 문의하기",
    "route": ""
    // "route": Routes.myPageRoutes.inquiringRoute
  },
  {
    "svg_path": SvgIconPath.announce,
    "title": "위라벨 소개",
    "route": ""
    // "route": Routes.onBoardingRoute,
  },
];

final _myPageViewDocButtonData = [
  {
    "svg_path": SvgIconPath.document,
    "title": "서비스 이용약관",
    "route": ""
    // "route": Routes.myPageRoutes.termConditionServiceRoute,
  },
  {
    "svg_path": SvgIconPath.document,
    "title": "개인정보 처리방침",
    "route": ""
    // "route": Routes.myPageRoutes.privacyPolicyRoute,
  },
];
