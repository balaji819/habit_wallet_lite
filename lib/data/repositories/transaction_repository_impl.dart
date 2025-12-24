import 'package:habit_wallet_lite/data/repositories/transaction_repository.dart';
import 'package:hive/hive.dart';

import 'package:habit_wallet_lite/data/local/transaction_hive_model.dart';
import 'package:habit_wallet_lite/domain/entities/transaction_entity.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Box<TransactionHiveModel> box;

  TransactionRepositoryImpl(this.box);

  @override
  Future<List<TransactionEntity>> getAll() async {
    final transactions = box.values.map(_toEntity).toList();
    transactions.sort(
          (a, b) => b.timestamp.compareTo(a.timestamp),
    );
    return transactions;
  }

  Future<void> add(TransactionEntity tx) async {
    await box.put(tx.id, _toHive(tx));
  }

  @override
  Future<void> addAll(List<TransactionEntity> transactions) async {
    final map = <String, TransactionHiveModel>{};
    for (final tx in transactions) {
      map[tx.id] = _toHive(tx);
    }
    await box.putAll(map);
  }

  @override
  Future<void> update(TransactionEntity tx) async {
    await box.put(
      tx.id,
      _toHive(
        tx.copyWith(
          editedLocally: true,
          updatedAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  Future<void> delete(String id) async {
    await box.delete(id);
  }

  // Mapping helpers

  TransactionEntity _toEntity(TransactionHiveModel model) {
    return TransactionEntity(
      id: model.id,
      amount: model.amount,
      category: model.category,
      timestamp: model.timestamp,
      note: model.note,
      isSynced: model.isSynced,
      editedLocally: model.editedLocally,
      updatedAt: model.updatedAt,
    );
  }

  TransactionHiveModel _toHive(TransactionEntity entity) {
    return TransactionHiveModel(
      id: entity.id,
      amount: entity.amount,
      category: entity.category,
      timestamp: entity.timestamp,
      note: entity.note,
      isSynced: entity.isSynced,
      editedLocally: entity.editedLocally,
      updatedAt: entity.updatedAt,
    );
  }

}
