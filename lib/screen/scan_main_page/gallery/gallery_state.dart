import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_gallery/photo_gallery.dart';

part 'gallery_state.freezed.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState({
    required String text,
    required bool isLoading,
    required List<Album>? albums,
    required List<String> albumNames,
    required List<Medium> mediums,
  }) = _GalleryState;

  factory GalleryState.initial() {
    return GalleryState(text: "", isLoading: false,albums: null,albumNames: [],mediums: []);
  }
}
