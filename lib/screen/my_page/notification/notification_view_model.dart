import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notification_state.dart';

class NotificationViewModel extends StateNotifier<NotificationState> {
  final provider = StateNotifierProvider<NotificationViewModel, NotificationState>((ref) {
    return NotificationViewModel();
  });

  NotificationViewModel() : super(NotificationState.initial());
}
