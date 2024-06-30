import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'announcement_state.dart';

class AnnouncementViewModel extends StateNotifier<AnnouncementState> {
  final provider = StateNotifierProvider<AnnouncementViewModel, AnnouncementState>((ref) {
    return AnnouncementViewModel();
  });

  AnnouncementViewModel() : super(AnnouncementState.initial());
}
