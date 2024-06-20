import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import "package:collection/collection.dart";

part 'mock_home_state.freezed.dart';

@freezed
class MockHomeState with _$MockHomeState {
  const factory MockHomeState({
    // 디테일 페이지에서 보여주고 수정할 post data
    required List<MockArchivingPost> listArchivingPosts,
    required Map<String, List<MockArchivingPost>> gridArchivingPosts,
  }) = _MockHomeState;

  factory MockHomeState.initial(List<MockArchivingPost> posts) {
    List<MockArchivingPost> _archivingPosts = [...posts];
    _archivingPosts.sort(
      (MockArchivingPost a, MockArchivingPost b) =>
          a.createAt!.compareTo(b.createAt!),
    );
    _archivingPosts = _archivingPosts.reversed.toList();

    // 1차원 리스트를 2차원 리스트로 변환 하는데 2차원 리스트에 원소를 whiksyName으로 그룹핑한다.
    Map<String, List<MockArchivingPost>> groupedArchivingPosts = groupBy(
      _archivingPosts,
      (archivingPost) => archivingPost.whiskyName,
    );

    return MockHomeState(
        listArchivingPosts: posts, gridArchivingPosts: groupedArchivingPosts);
  }
}
