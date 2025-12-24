import 'package:habit_wallet_lite/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getAll();
  Future<void> update(TransactionEntity tx);
  Future<void> delete(String id);
  Future<void> addAll(List<TransactionEntity> transactions);

}
