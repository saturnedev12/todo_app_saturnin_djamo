// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskEntityImpl _$$TaskEntityImplFromJson(Map<String, dynamic> json) =>
    _$TaskEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      color: json['color'] as String?,
      reminder: json['reminder'] == null
          ? null
          : DateTime.parse(json['reminder'] as String),
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$TaskEntityImplToJson(_$TaskEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'color': instance.color,
      'reminder': instance.reminder?.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
    };
