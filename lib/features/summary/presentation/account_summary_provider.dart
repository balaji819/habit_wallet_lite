import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/core/utils/bank_summary_loader.dart';
import 'package:habit_wallet_lite/domain/entities/account_summary.dart';

final accountSummaryProvider =
FutureProvider<AccountSummary>((ref) async {
  return BankSummaryLoader.loadFromAssets(
    'assets/mock/bank_transactions.json',
  );
});
