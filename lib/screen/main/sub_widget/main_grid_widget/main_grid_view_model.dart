

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/domain/whiskypost_response.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_state.dart';

import '../../../../enums/pagin_enum.dart';
import '../../../../service/whisky_service.dart';

class MainGridViewModel extends StateNotifier<MainGridState> {
  MainGridViewModel() : super(MainGridState.initial());

  bool _lock = false;
  int _currentPage = 0;
  bool _hasMore = true;
  final _whiskyService = WhiskyService();
  BuildContext? _context;


  final provider = StateNotifierProvider<MainGridViewModel,MainGridState> ((_) {
    return MainGridViewModel();
  });

  void callWhiskyPostGridAPI(PagingType pagingType) async {
    if (_lock || _hasMore == false) {
      return;
    }
    _lock = true;
    if (pagingType == PagingType.paging) {
      _currentPage += 1;
    }
    else {
      _currentPage = 0;
    }

    final (isSuccess,result) = await _whiskyService.getGridPosts(_currentPage);

    if(isSuccess) {
      if ((result.data?.length ?? 0) == 0) {
        _hasMore = false;
      }
      if (pagingType == PagingType.paging) {
        state = state.copyWith(data: state.data + (result.data ?? []));
      }
      else {
        state = state.copyWith(data: (result.data ?? []));
      }
    }
    else {
      _currentPage -= 1;
    }
    _lock = false;
  }

  List<WhiskyPostResponse> getDuplicateWhiskyCount(int id) {
    final data = state.data;
    return  data.where((item) {
      return item.whiskyId == id;
    }).toList();
  }

  void setBuildContext(BuildContext context) {
    this._context = context;
  }

}