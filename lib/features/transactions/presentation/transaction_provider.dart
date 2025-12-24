import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:habit_wallet_lite/data/local/transaction_hive_model.dart';
import 'package:habit_wallet_lite/data/repositories/transaction_repository_impl.dart';
import 'package:habit_wallet_lite/domain/entities/transaction_entity.dart';
import 'package:habit_wallet_lite/core/utils/bank_json_importer.dart';

final transactionRepositoryProvider = Provider((ref) {
  final box = Hive.box<TransactionHiveModel>('transactions');
  return TransactionRepositoryImpl(box);
});

// AUTO IMPORT (RUNS ONCE)
final transactionImportProvider = FutureProvider<void>((ref) async {
  final repo = ref.read(transactionRepositoryProvider);

  // Avoid duplicate import
  if ((await repo.getAll()).isNotEmpty) return;

  // CALL IMPORTER, NOT REPOSITORY
  final transactions = await BankJsonImporter.importFromAssets(
    'assets/mock/bank_transactions.json',
  );
  // MARK IMPORTED TX AS SYNCED
  transactions.map(
        (tx) => tx.copyWith(isSynced: true),
  ).toList();


  await repo.addAll(transactions);
});

/// Transaction list
final transactionListProvider =
FutureProvider<List<TransactionEntity>>((ref) async {
  return ref.read(transactionRepositoryProvider).getAll();
});
