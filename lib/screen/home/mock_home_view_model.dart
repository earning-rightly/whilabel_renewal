import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';

import './mock_home_state.dart';

final mockHomeViewModelProvider =
    StateNotifierProvider<MockHomeViewModel, MockHomeState>(
        (ref) => MockHomeViewModel(ref));

class MockHomeViewModel extends StateNotifier<MockHomeState> {
  final Ref ref;

  MockHomeViewModel(this.ref) : super(MockHomeState.initial());

  Future<List<MockArchivingPost>> getArchivingPosts() async {
    return state.posts;
  }

  /* TODO detaill view에서 사용됨
   추후에 서버에서 post를 데이터를 받아오는 것으로 바뀔 예정  **/
  Future<void> updateArchivingPost(int postId, double starScore, String note,
      List<TasteFeature> features) async {
    final _posts = state.posts;

    int index = _posts.indexWhere((post) => post.postId == postId);

    print('home.updateArchivingPost$postId $starScore');
    if (index != -1) {
      final newPost = _posts[index].copyWith(
        starValue: starScore,
        note: note,
        tasteFeatures: features,
      );

      state = state.copyWith(
          posts:
              _posts.sublist(0, index) + [newPost] + _posts.sublist(index + 1));
    }
  }
}