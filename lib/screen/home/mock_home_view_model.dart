import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/data/mock_data/data.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';

import './mock_home_state.dart';

class MockHomeViewModel extends StateNotifier<MockHomeState> {
  final provider = StateNotifierProvider<MockHomeViewModel, MockHomeState>(
      (ref) => MockHomeViewModel());

  MockHomeViewModel() : super(MockHomeState.initial([mockPost1,mockPost2,mockPost3]));

  Future<List<MockArchivingPost>> getListArchivingPosts() async {
    return state.listArchivingPosts;
  }

  /* TODO detaill view에서 사용됨
   추후에 서버에서 post를 데이터를 받아오는 것으로 바뀔 예정  **/
  Future<void> updateArchivingPost(int postId, double starScore, String note,
      List<TasteFeature> features) async {
    final _posts = state.listArchivingPosts;

    int index = _posts.indexWhere((post) => post.postId == postId);

    print('home.updateArchivingPost$postId $starScore');
    if (index != -1) {
      final newPost = _posts[index].copyWith(
        starValue: starScore,
        note: note,
        tasteFeatures: features,
      );

      state = state.copyWith(
          listArchivingPosts:
              _posts.sublist(0, index) + [newPost] + _posts.sublist(index + 1));
    }
  }
}
