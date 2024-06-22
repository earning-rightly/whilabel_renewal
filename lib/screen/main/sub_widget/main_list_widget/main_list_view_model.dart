

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whilabel_renewal/enums/pagin_enum.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_list_widget/main_list_state.dart';
import 'package:whilabel_renewal/service/whisky_service.dart';

class MainListViewModel extends StateNotifier<MainListState>  {

  MainListViewModel() : super(MainListState.initial());

  bool _lock = false;
  int _currentPage = 0;
  bool _hasMore = true;
  final _whiskyService = WhiskyService();
  BuildContext? _context;

  final provider = StateNotifierProvider<MainListViewModel,MainListState>( (ref) {
    return MainListViewModel();
  });



  void callWhiskyPostListAPI(PagingType pagingType) async {
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

    final (isSuccess,result) = await _whiskyService.getPosts(state.currentSortType, _currentPage);

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

  void sortChanged(String sort) async {
    _hasMore = true;
    state = state.copyWith(currentSortType: sort);
    callWhiskyPostListAPI(PagingType.refresh);
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy.MM.dd').format(dateTime);
  }

  int getDuplicateWhiskyCount(int id) {
    final data = state.data;
    return data.where((item) {
      return item.whiskyId == id;
    }).length;
  }


}