import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuVisibiltiyNotifier extends StateNotifier<bool> {
  Timer? timer;
  final Duration duration;
  MenuVisibiltiyNotifier({
    required bool isVisible,
    required this.duration,
  }) : super(true) {
    showWithTimeOut();
  }

  showWithTimeOut() {
    timer?.cancel();
    state = true;
    if (duration != Duration.zero) {
      timer = Timer(duration, () {
        if (mounted) {
          state = false;
        }
      });
    }
  }

  hide() {
    timer?.cancel();
    state = false;
  }

  holdMore() => showWithTimeOut();
  onDispose() {
    timer?.cancel();
  }
}

final menuVisibilityProvider =
    StateNotifierProvider<MenuVisibiltiyNotifier, bool>((ref) {
  throw Exception(
      "menuVisibilityProvider is available only inside the overlay_menu");
});
