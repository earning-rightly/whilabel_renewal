import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/data/mock_data/data.dart';

part 'mock_home_state.freezed.dart';

@freezed
class MockHomeState with _$MockHomeState {
  const factory MockHomeState({
    // 디테일 페이지에서 보여주고 수정할 post data
    required List<MockArchivingPost> posts,
  }) = _MockHomeState;

  factory MockHomeState.initial() {
    return MockHomeState( posts: [mockPost1, mockPost2]);
  }
}
