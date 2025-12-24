
part of 'transaction_entity.dart';

// JsonSerializableGenerator

_$TransactionEntityImpl _$$TransactionEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionEntityImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      valueDate: json['valueDate'] == null
          ? null
          : DateTime.parse(json['valueDate'] as String),
      note: json['note'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isSynced: json['isSynced'] as bool? ?? false,
      editedLocally: json['editedLocally'] as bool? ?? false,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TransactionEntityImplToJson(
        _$TransactionEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'category': instance.category,
      'timestamp': instance.timestamp.toIso8601String(),
      'valueDate': instance.valueDate?.toIso8601String(),
      'note': instance.note,
      'attachments': instance.attachments,
      'isSynced': instance.isSynced,
      'editedLocally': instance.editedLocally,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
