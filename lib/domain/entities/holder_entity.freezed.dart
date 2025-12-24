
part of 'holder_entity.dart';

// FreezedGenerator

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HolderEntity _$HolderEntityFromJson(Map<String, dynamic> json) {
  return _HolderEntity.fromJson(json);
}

/// @nodoc
mixin _$HolderEntity {
  String get name => throw _privateConstructorUsedError;
  DateTime get dob => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  String get nominee => throw _privateConstructorUsedError;
  String get landline => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get pan =>
      throw _privateConstructorUsedError;
  bool get ckycCompliance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HolderEntityCopyWith<HolderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolderEntityCopyWith<$Res> {
  factory $HolderEntityCopyWith(
          HolderEntity value, $Res Function(HolderEntity) then) =
      _$HolderEntityCopyWithImpl<$Res, HolderEntity>;
  @useResult
  $Res call(
      {String name,
      DateTime dob,
      String mobile,
      String nominee,
      String landline,
      String address,
      String email,
      String pan,
      bool ckycCompliance});
}

/// @nodoc
class _$HolderEntityCopyWithImpl<$Res, $Val extends HolderEntity>
    implements $HolderEntityCopyWith<$Res> {
  _$HolderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dob = null,
    Object? mobile = null,
    Object? nominee = null,
    Object? landline = null,
    Object? address = null,
    Object? email = null,
    Object? pan = null,
    Object? ckycCompliance = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mobile: null == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String,
      nominee: null == nominee
          ? _value.nominee
          : nominee // ignore: cast_nullable_to_non_nullable
              as String,
      landline: null == landline
          ? _value.landline
          : landline // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      pan: null == pan
          ? _value.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String,
      ckycCompliance: null == ckycCompliance
          ? _value.ckycCompliance
          : ckycCompliance // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HolderEntityImplCopyWith<$Res>
    implements $HolderEntityCopyWith<$Res> {
  factory _$$HolderEntityImplCopyWith(
          _$HolderEntityImpl value, $Res Function(_$HolderEntityImpl) then) =
      __$$HolderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      DateTime dob,
      String mobile,
      String nominee,
      String landline,
      String address,
      String email,
      String pan,
      bool ckycCompliance});
}

/// @nodoc
class __$$HolderEntityImplCopyWithImpl<$Res>
    extends _$HolderEntityCopyWithImpl<$Res, _$HolderEntityImpl>
    implements _$$HolderEntityImplCopyWith<$Res> {
  __$$HolderEntityImplCopyWithImpl(
      _$HolderEntityImpl _value, $Res Function(_$HolderEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dob = null,
    Object? mobile = null,
    Object? nominee = null,
    Object? landline = null,
    Object? address = null,
    Object? email = null,
    Object? pan = null,
    Object? ckycCompliance = null,
  }) {
    return _then(_$HolderEntityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mobile: null == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String,
      nominee: null == nominee
          ? _value.nominee
          : nominee // ignore: cast_nullable_to_non_nullable
              as String,
      landline: null == landline
          ? _value.landline
          : landline // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      pan: null == pan
          ? _value.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String,
      ckycCompliance: null == ckycCompliance
          ? _value.ckycCompliance
          : ckycCompliance // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HolderEntityImpl implements _HolderEntity {
  const _$HolderEntityImpl(
      {required this.name,
      required this.dob,
      required this.mobile,
      required this.nominee,
      required this.landline,
      required this.address,
      required this.email,
      required this.pan,
      required this.ckycCompliance});

  factory _$HolderEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$HolderEntityImplFromJson(json);

  @override
  final String name;
  @override
  final DateTime dob;
  @override
  final String mobile;
  @override
  final String nominee;
  @override
  final String landline;
  @override
  final String address;
  @override
  final String email;
  @override
  final String pan;

  @override
  final bool ckycCompliance;

  @override
  String toString() {
    return 'HolderEntity(name: $name, dob: $dob, mobile: $mobile, nominee: $nominee, landline: $landline, address: $address, email: $email, pan: $pan, ckycCompliance: $ckycCompliance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolderEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.nominee, nominee) || other.nominee == nominee) &&
            (identical(other.landline, landline) ||
                other.landline == landline) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.pan, pan) || other.pan == pan) &&
            (identical(other.ckycCompliance, ckycCompliance) ||
                other.ckycCompliance == ckycCompliance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, dob, mobile, nominee,
      landline, address, email, pan, ckycCompliance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HolderEntityImplCopyWith<_$HolderEntityImpl> get copyWith =>
      __$$HolderEntityImplCopyWithImpl<_$HolderEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HolderEntityImplToJson(
      this,
    );
  }
}

abstract class _HolderEntity implements HolderEntity {
  const factory _HolderEntity(
      {required final String name,
      required final DateTime dob,
      required final String mobile,
      required final String nominee,
      required final String landline,
      required final String address,
      required final String email,
      required final String pan,
      required final bool ckycCompliance}) = _$HolderEntityImpl;

  factory _HolderEntity.fromJson(Map<String, dynamic> json) =
      _$HolderEntityImpl.fromJson;

  @override
  String get name;
  @override
  DateTime get dob;
  @override
  String get mobile;
  @override
  String get nominee;
  @override
  String get landline;
  @override
  String get address;
  @override
  String get email;
  @override
  String get pan;
  @override // Correct annotation usage
  bool get ckycCompliance;
  @override
  @JsonKey(ignore: true)
  _$$HolderEntityImplCopyWith<_$HolderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
