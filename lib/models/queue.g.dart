// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Queue _$QueueFromJson(Map<String, dynamic> json) => Queue(
      json['qreceipt'] as int?,
      json['qtime'] as String?,
      json['qwaiting'] as int?,
    );

Map<String, dynamic> _$QueueToJson(Queue instance) => <String, dynamic>{
      'qreceipt': instance.qreceipt,
      'qtime': instance.qtime,
      'qwaiting': instance.qwaiting,
    };
