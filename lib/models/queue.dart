import 'package:json_annotation/json_annotation.dart';

part 'queue.g.dart';

@JsonSerializable()
class Queue {
  int? qreceipt;
  String? qtime;
  int? qwaiting;

  Queue(this.qreceipt, this.qtime, this.qwaiting);

  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);

  Map<String, dynamic> toJson() => _$QueueToJson(this);
}
