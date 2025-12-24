import 'package:hive/hive.dart';

part 'transaction_hive_model.g.dart';

@HiveType(typeId: 0)
class TransactionHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String category;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4)
  String? note;

  @HiveField(5)
  bool isSynced;

  @HiveField(6)
  bool editedLocally;

  @HiveField(7)
  DateTime updatedAt;

  TransactionHiveModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.timestamp,
    this.note,
    required this.isSynced,
    required this.editedLocally,
    required this.updatedAt,
  });
}
