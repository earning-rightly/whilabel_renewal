import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/main/main_view_model.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_widget.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_list_widget/main_list_widget.dart';
import 'package:whilabel_renewal/screen/my_page/my_page_view.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final _viewModel = MainViewModel();

  final listView = MainListWidget();
  final gridView = MainGridWidget();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ref.read(_viewModel.provider.notifier).init();
    final state = ref.watch(_viewModel.provider);


    return Container(
      color: ColorsManager.black100,
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
      child: Scaffold(
        backgroundColor: ColorsManager.black100,
        appBar: _appBar(context, ref),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  border: const Border(
                    bottom: BorderSide(color: ColorsManager.black100, width: 1),
                  ),
                ),
                child: TabBar(
                  onTap: (index) {
                    ref.read(_viewModel.provider.notifier).setCurrentIndex(index);
                  },
                  controller: _tabController,
                  unselectedLabelColor: ColorsManager.black100,
                  indicator: const UnderlineTabIndicator(
                    insets: EdgeInsets.symmetric(horizontal: -50),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  tabs: [
                    Tab(
                      icon: SvgPicture.asset(SvgIconPath.list,color: state.currentIndex == 0 ? Colors.white : ColorsManager.gray),
                    ),
                    Tab(
                      icon: SvgPicture.asset(SvgIconPath.grid,color: state.currentIndex == 1 ? Colors.white : ColorsManager.gray),
                    )
                  ],
                ),
              ),

              //tabbarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    listView,
                    gridView,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_viewModel.provider);

    return AppBar(
      backgroundColor: ColorsManager.black100,
      leading: Row(
        children: [
           Text(
            state.text.title,
            style: TextStylesManager.bold24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              "${state.whiskyCount}",
              style: TextStylesManager.createHadColorTextStyle(
                  "M20", ColorsManager.brown100),
            ),
          ),
        ],
      ),
      leadingWidth: 300,
      actions: [_appBarNotificationBtn(context, ref)],
    );
  }

  Widget _appBarNotificationBtn(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_viewModel.provider);

    return IconButton(
      splashColor: ColorsManager.black300,
      splashRadius: 15,
      color: ColorsManager.gray200,
      icon: SvgPicture.asset(state.hasNotification ? SvgIconPath.notificationNew :SvgIconPath.notification),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
      style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          iconSize: 24),
      onPressed: () {
        // Navigator.pushNamed(context, Routes.myPageRoutes.announcementRoute);
      },
    );
  }
}
