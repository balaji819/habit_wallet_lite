import 'package:freezed_annotation/freezed_annotation.dart';

part 'holder_entity.freezed.dart';
part 'holder_entity.g.dart';

@freezed
class HolderEntity with _$HolderEntity {
  const factory HolderEntity({
    required String name,
    required DateTime dob,
    required String mobile,
    required String nominee,
    required String landline,
    required String address,
    required String email,
    required String pan,


    required bool ckycCompliance,
  }) = _HolderEntity;

  factory HolderEntity.fromJson(Map<String, dynamic> json) =>
      _$HolderEntityFromJson(json);
}

