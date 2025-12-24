import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/domain/entities/transaction_entity.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/transaction_provider.dart';

/// Selected month
final selectedMonthProvider =
StateProvider<DateTime>((ref) => DateTime.now());

/// Transactions filtered by month
final monthlyTransactionsProvider =
Provider<List<TransactionEntity>>((ref) {
  final allTx =
      ref.watch(transactionListProvider).value ?? [];
  final month = ref.watch(selectedMonthProvider);

  return allTx.where((tx) {
    return tx.timestamp.year == month.year &&
        tx.timestamp.month == month.month;
  }).toList();
});

/// Income vs Expense
final incomeExpenseProvider =
Provider<Map<String, double>>((ref) {
  final txs = ref.watch(monthlyTransactionsProvider);

  double income = 0;
  double expense = 0;

  for (final tx in txs) {
    if (tx.amount >= 0) {
      income += tx.amount;
    } else {
      expense += tx.amount.abs();
    }
  }

  return {
    'income': income,
    'expense': expense,
  };
});

/// Category breakdown
final categoryBreakdownProvider =
Provider<Map<String, double>>((ref) {
  final txs = ref.watch(monthlyTransactionsProvider);
  final map = <String, double>{};

  for (final tx in txs) {
    map[tx.category] =
        (map[tx.category] ?? 0) + tx.amount.abs();
  }

  return map;
});
