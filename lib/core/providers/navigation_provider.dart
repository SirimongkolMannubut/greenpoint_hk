import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalNavigationProvider = StateNotifierProvider<GlobalNavigationNotifier, int>((ref) {
  return GlobalNavigationNotifier();
});

class GlobalNavigationNotifier extends StateNotifier<int> {
  GlobalNavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  void goToHome() {
    state = 0;
  }
}
