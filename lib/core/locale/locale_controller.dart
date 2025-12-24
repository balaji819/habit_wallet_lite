import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends StateNotifier<Locale> {
  LocaleController() : super(const Locale('en')) {
    _loadLocale();
  }

  static const _key = 'app_locale';

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null) {
      state = Locale(code);
    }
  }

  Future<void> toggleLocale() async {
    final prefs = await SharedPreferences.getInstance();

    final newLocale =
    state.languageCode == 'en' ? const Locale('ta') : const Locale('en');

    state = newLocale;
    await prefs.setString(_key, newLocale.languageCode);
  }
}

final localeProvider =
StateNotifierProvider<LocaleController, Locale>(
      (ref) => LocaleController(),
);
