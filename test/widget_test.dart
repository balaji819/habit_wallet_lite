import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/main.dart';

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: HabitWalletApp(),
      ),
    );

    await tester.pump(); // single pump is enough

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
