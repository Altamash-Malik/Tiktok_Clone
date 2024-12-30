import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final settingsViewModelProvider =
    ChangeNotifierProvider.autoDispose<SettingsViewModel>((ref) {
  return SettingsViewModel(ref);
});
class SettingsViewModel extends ChangeNotifier {
  final Ref ref;
  SettingsViewModel(this.ref);

 
}