import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/transaction_provider.dart';
import 'package:habit_wallet_lite/features/summary/presentation/account_summary_provider.dart';

//  Bank-style current balance
final currentBalanceProvider = Provider<double>((ref) {
  final txAsync = ref.watch(transactionListProvider);
  final summaryAsync = ref.watch(accountSummaryProvider);

  double openingBalance = 0;
  double total = 0;

  summaryAsync.whenData((summary) {
    openingBalance = summary.balance;
  });

  txAsync.whenData((txs) {
    for (final tx in txs) {
      total += tx.amount; // + income, - expense
    }
  });

  return openingBalance + total;
});
