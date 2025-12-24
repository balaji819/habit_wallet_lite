import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';
part 'transaction_entity.g.dart';

@freezed
class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required String id,

    /// Positive = income, Negative = expense
    required double amount,

    required String category,

    /// Actual transaction time
    required DateTime timestamp,

    /// Bank settlement date (from bank statement)
    DateTime? valueDate,

    String? note,

    @Default(false) bool isSynced,

    @Default(false) bool editedLocally,

    required DateTime updatedAt,
  }) = _TransactionEntity;

  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);
}
