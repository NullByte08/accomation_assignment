/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationModel {
  bool darkMode = false;

  ApplicationModel({required this.darkMode});
}

class ApplicationModelNotifier extends StateNotifier<ApplicationModel> {
  ApplicationModelNotifier()
      : super(ApplicationModel(
          darkMode: false,
        ));

  switchDarkMode() {
    state = ApplicationModel(darkMode: !state.darkMode);
  }
}

final applicationModelProvider = StateNotifierProvider<ApplicationModelNotifier, ApplicationModel>((ref) {
  return ApplicationModelNotifier();
});
