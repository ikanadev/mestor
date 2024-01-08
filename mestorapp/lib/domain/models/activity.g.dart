// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      color: $enumDecode(_$ActColorEnumMap, json['color']),
      createAt: DateTime.parse(json['createAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'emoji': instance.emoji,
      'color': _$ActColorEnumMap[instance.color]!,
      'createAt': instance.createAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$ActColorEnumMap = {
  ActColor.pink: 'pink',
  ActColor.red: 'red',
  ActColor.orange: 'orange',
  ActColor.deepOrange: 'deepOrange',
  ActColor.amber: 'amber',
  ActColor.yellow: 'yellow',
  ActColor.lime: 'lime',
  ActColor.lightGreen: 'lightGreen',
  ActColor.green: 'green',
  ActColor.teal: 'teal',
  ActColor.cyan: 'cyan',
  ActColor.lightBlue: 'lightBlue',
  ActColor.blue: 'blue',
  ActColor.indigo: 'indigo',
  ActColor.purple: 'purple',
  ActColor.deepPurple: 'deepPurple',
  ActColor.blueGrey: 'blueGrey',
  ActColor.brown: 'brown',
  ActColor.grey: 'grey',
};
