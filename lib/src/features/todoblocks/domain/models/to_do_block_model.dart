import 'package:todoblock_mobile_app/src/features/todos/domain/models/timestamp_extension.dart';

import '../../../todos/domain/models/todo_model.dart';
class ToDoBlockModel {
  int? id;
  ToDoModel? todoRef; //TODO Join mit alias als todoREf
  int? start_time;
  int? duration;
  DateTime? date;

  ToDoBlockModel({
    this.id,
    this.todoRef,
    this.start_time,
    this.duration,
    this.date,
  });

  factory ToDoBlockModel.fromJson(Map<String, dynamic> json) {
    return ToDoBlockModel(
      id: json['id'],
      todoRef: json['todoRef'] != null ? ToDoModel.fromJson(json['todoRef']) : null,
      start_time: TimestampExtension.fromDateTime((json['start_time'] as int).toDateTimeUtc),
      duration: json['duration'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoRef': todoRef?.toJson(),
      'startTime': start_time,
      'duration': duration,
      'date': date?.toIso8601String(),
    };
  }
}
