import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/domain/whiskypost_response.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_state.dart';

import '../../../../enums/pagin_enum.dart';
import '../../../../service/whisky_service.dart';
import 'sub_widgets/expaneded_whisky_post_image.dart';

class MainGridViewModel extends StateNotifier<MainGridState> {
  MainGridViewModel() : super(MainGridState.initial());

  bool _lock = false;
  int _currentPage = 0;
  bool _hasMore = true;
  final _whiskyService = WhiskyService();
  BuildContext? _context;

  final provider = StateNotifierProvider<MainGridViewModel, MainGridState>((_) {
    return MainGridViewModel();
  });

  void callWhiskyPostGridAPI(PagingType pagingType) async {
    if (_lock || _hasMore == false) {
      return;
    }
    _lock = true;
    if (pagingType == PagingType.paging) {
      _currentPage += 1;
    } else {
      _currentPage = 0;
    }

    final (isSuccess, result) = await _whiskyService.getGridPosts(_currentPage);

    if (isSuccess) {
      if ((result.data?.length ?? 0) == 0) {
        _hasMore = false;
      }
      if (pagingType == PagingType.paging) {
        state = state.copyWith(data: state.data + (result.data ?? []));
      } else {
        state = state.copyWith(data: (result.data ?? []));
      }
    } else {
      _currentPage -= 1;
    }
    _lock = false;
  }

  List<WhiskyPostResponse> getDuplicateWhiskys(int id) {
    final data = state.data;
    return data.where((post) {
      return post.whiskyId == id;
    }).toList();
  }

  void setBuildContext(BuildContext context) {
    this._context = context;
  }

  void showExpendingImage(
    BuildContext context, {
    required Function(int) onTapExpandedImageEvent,
    required List<WhiskyPostResponse> posts,
    required double height,
    required double width,
  }) {
    showDialog(
      context: context,
      builder: (context) => SafeArea(
        child: Stack(
          children: [
            BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 6.0,
                sigmaY: 6.0,
              ),
              child: Container(
                height: height,
                width: width,
              ),
            ),
            Positioned(
              top: 12,
              right: 0,
              left: 0,
              child: ExpandedWhiskyPostImage(
                useDots: true,
                dotsAlignment: Alignment.bottomCenter,
                dotsColorInactive: ColorsManager.gray500,
                dotsColorActive: ColorsManager.white,
                height: height * 0.6,
                context: context,
                images: [
                  for (WhiskyPostResponse whiskeyNameGroupedArchivingPost
                      in posts)
                    whiskeyNameGroupedArchivingPost.imageUrl,
                ],
                onClick: onTapExpandedImageEvent
              ),
            ),
          ],
        ),
      ),
    );
  }
}
