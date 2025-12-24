
part of 'transaction_hive_model.dart';

// TypeAdapterGenerator

class TransactionHiveModelAdapter extends TypeAdapter<TransactionHiveModel> {
  @override
  final int typeId = 0;

  @override
  TransactionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionHiveModel(
      id: fields[0] as String,
      amount: fields[1] as double,
      category: fields[2] as String,
      timestamp: fields[3] as DateTime,
      note: fields[4] as String?,
      isSynced: fields[5] as bool,
      editedLocally: fields[6] as bool,
      updatedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.isSynced)
      ..writeByte(6)
      ..write(obj.editedLocally)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
