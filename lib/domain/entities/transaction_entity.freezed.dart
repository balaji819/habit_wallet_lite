
part of 'transaction_entity.dart';

// FreezedGenerator

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionEntity _$TransactionEntityFromJson(Map<String, dynamic> json) {
  return _TransactionEntity.fromJson(json);
}

/// @nodoc
mixin _$TransactionEntity {
  String get id => throw _privateConstructorUsedError;

  /// Positive = income, Negative = expense
  double get amount => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  /// Actual transaction time
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Bank settlement date (from bank statement)
  DateTime? get valueDate => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// 📎 ATTACHMENTS (LOCAL FILE PATHS)
  List<String> get attachments => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  bool get editedLocally => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionEntityCopyWith<TransactionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionEntityCopyWith<$Res> {
  factory $TransactionEntityCopyWith(
          TransactionEntity value, $Res Function(TransactionEntity) then) =
      _$TransactionEntityCopyWithImpl<$Res, TransactionEntity>;
  @useResult
  $Res call(
      {String id,
      double amount,
      String category,
      DateTime timestamp,
      DateTime? valueDate,
      String? note,
      List<String> attachments,
      bool isSynced,
      bool editedLocally,
      DateTime updatedAt});
}

/// @nodoc
class _$TransactionEntityCopyWithImpl<$Res, $Val extends TransactionEntity>
    implements $TransactionEntityCopyWith<$Res> {
  _$TransactionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? category = null,
    Object? timestamp = null,
    Object? valueDate = freezed,
    Object? note = freezed,
    Object? attachments = null,
    Object? isSynced = null,
    Object? editedLocally = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      valueDate: freezed == valueDate
          ? _value.valueDate
          : valueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      editedLocally: null == editedLocally
          ? _value.editedLocally
          : editedLocally // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionEntityImplCopyWith<$Res>
    implements $TransactionEntityCopyWith<$Res> {
  factory _$$TransactionEntityImplCopyWith(_$TransactionEntityImpl value,
          $Res Function(_$TransactionEntityImpl) then) =
      __$$TransactionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double amount,
      String category,
      DateTime timestamp,
      DateTime? valueDate,
      String? note,
      List<String> attachments,
      bool isSynced,
      bool editedLocally,
      DateTime updatedAt});
}

/// @nodoc
class __$$TransactionEntityImplCopyWithImpl<$Res>
    extends _$TransactionEntityCopyWithImpl<$Res, _$TransactionEntityImpl>
    implements _$$TransactionEntityImplCopyWith<$Res> {
  __$$TransactionEntityImplCopyWithImpl(_$TransactionEntityImpl _value,
      $Res Function(_$TransactionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? category = null,
    Object? timestamp = null,
    Object? valueDate = freezed,
    Object? note = freezed,
    Object? attachments = null,
    Object? isSynced = null,
    Object? editedLocally = null,
    Object? updatedAt = null,
  }) {
    return _then(_$TransactionEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      valueDate: freezed == valueDate
          ? _value.valueDate
          : valueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      editedLocally: null == editedLocally
          ? _value.editedLocally
          : editedLocally // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionEntityImpl implements _TransactionEntity {
  const _$TransactionEntityImpl(
      {required this.id,
      required this.amount,
      required this.category,
      required this.timestamp,
      this.valueDate,
      this.note,
      final List<String> attachments = const <String>[],
      this.isSynced = false,
      this.editedLocally = false,
      required this.updatedAt})
      : _attachments = attachments;

  factory _$TransactionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionEntityImplFromJson(json);

  @override
  final String id;

  /// Positive = income, Negative = expense
  @override
  final double amount;
  @override
  final String category;

  /// Actual transaction time
  @override
  final DateTime timestamp;

  /// Bank settlement date (from bank statement)
  @override
  final DateTime? valueDate;
  @override
  final String? note;

  /// 📎 ATTACHMENTS (LOCAL FILE PATHS)
  final List<String> _attachments;

  /// 📎 ATTACHMENTS (LOCAL FILE PATHS)
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  @JsonKey()
  final bool isSynced;
  @override
  @JsonKey()
  final bool editedLocally;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TransactionEntity(id: $id, amount: $amount, category: $category, timestamp: $timestamp, valueDate: $valueDate, note: $note, attachments: $attachments, isSynced: $isSynced, editedLocally: $editedLocally, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.valueDate, valueDate) ||
                other.valueDate == valueDate) &&
            (identical(other.note, note) || other.note == note) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.editedLocally, editedLocally) ||
                other.editedLocally == editedLocally) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      amount,
      category,
      timestamp,
      valueDate,
      note,
      const DeepCollectionEquality().hash(_attachments),
      isSynced,
      editedLocally,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionEntityImplCopyWith<_$TransactionEntityImpl> get copyWith =>
      __$$TransactionEntityImplCopyWithImpl<_$TransactionEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionEntityImplToJson(
      this,
    );
  }
}

abstract class _TransactionEntity implements TransactionEntity {
  const factory _TransactionEntity(
      {required final String id,
      required final double amount,
      required final String category,
      required final DateTime timestamp,
      final DateTime? valueDate,
      final String? note,
      final bool isSynced,
      final bool editedLocally,
      required final DateTime updatedAt}) = _$TransactionEntityImpl;

  factory _TransactionEntity.fromJson(Map<String, dynamic> json) =
      _$TransactionEntityImpl.fromJson;

  @override
  String get id;
  @override

  /// Positive = income, Negative = expense
  double get amount;
  @override
  String get category;
  @override

  /// Actual transaction time
  DateTime get timestamp;
  @override

  /// Bank settlement date (from bank statement)
  DateTime? get valueDate;
  @override
  String? get note;
  @override

  /// 📎 ATTACHMENTS (LOCAL FILE PATHS)
  List<String> get attachments;
  @override
  bool get isSynced;
  @override
  bool get editedLocally;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TransactionEntityImplCopyWith<_$TransactionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
