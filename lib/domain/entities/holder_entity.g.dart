
part of 'holder_entity.dart';

// JsonSerializableGenerator

_$HolderEntityImpl _$$HolderEntityImplFromJson(Map<String, dynamic> json) =>
    _$HolderEntityImpl(
      name: json['name'] as String,
      dob: DateTime.parse(json['dob'] as String),
      mobile: json['mobile'] as String,
      nominee: json['nominee'] as String,
      landline: json['landline'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      pan: json['pan'] as String,
      ckycCompliance: json['ckycCompliance'] as bool,
    );

Map<String, dynamic> _$$HolderEntityImplToJson(_$HolderEntityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dob': instance.dob.toIso8601String(),
      'mobile': instance.mobile,
      'nominee': instance.nominee,
      'landline': instance.landline,
      'address': instance.address,
      'email': instance.email,
      'pan': instance.pan,
      'ckycCompliance': instance.ckycCompliance,
    };
