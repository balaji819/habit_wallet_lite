import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/core/locale/locale_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_wallet_lite/core/theme/theme_provider.dart';
import 'package:habit_wallet_lite/core/notifications/notification_service.dart';
import 'package:habit_wallet_lite/data/local/transaction_hive_model.dart';
import 'package:habit_wallet_lite/features/auth/presentation/auth_controller.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_screen.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/transaction_list_screen.dart';
import 'package:habit_wallet_lite/l10n/app_localizations.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// ✅ GLOBAL FLUTTER ERRORS
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    _logCrash(details.exception, details.stack);
  };

  /// ✅ DART / ISOLATE ERRORS
  PlatformDispatcher.instance.onError = (error, stack) {
    _logCrash(error, stack);
    return true; // prevents app from crashing
  };

  // 🔔 Notifications
  await NotificationService.init();
  // await NotificationService.showTestNotification();

  // 💾 Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionHiveModelAdapter());
  await Hive.openBox<TransactionHiveModel>('transactions');

  runApp(
    const ProviderScope(
      child: HabitWalletApp(),
    ),
  );
}
void _logCrash(Object error, StackTrace? stack) {
  debugPrint('🔥 GLOBAL CRASH CAUGHT');
  debugPrint(error.toString());
  if (stack != null) {
    debugPrint(stack.toString());
  }
}

class HabitWalletApp extends ConsumerWidget {
  const HabitWalletApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final themeMode = ref.watch(themeModeProvider);
    // final locale = ref.watch(localeProvider); // ✅ KEY LINE


    return MaterialApp(
      title: 'Habit Wallet Lite',
      debugShowCheckedModeBanner: false,

      /// 🌐 i18n — THIS MAKES LANGUAGE SWITCH WORK
      locale: ref.watch(localeProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      /// 🌗 Theme
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),

      /// 🔐 Auth-driven navigation
      home: authState.when(
        data: (isLoggedIn) =>
        isLoggedIn ? const TransactionListScreen() : const LoginScreen(),
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (_, __) => const LoginScreen(),
      ),
    );
  }
}
