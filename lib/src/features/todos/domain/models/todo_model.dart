import 'package:todoblock_mobile_app/src/features/todos/domain/models/timestamp_extension.dart';
import 'priority_extension.dart';

class ToDoModel {
  int? id;
  String? title;
  String? description;
  int? duration;
  int? deadline;
  bool dailygoal = false;
  bool later = false;
  Priority? priority;
  bool finished = false;

  ToDoModel({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.deadline,
    this.dailygoal = false,
    this.later = false,
    this.priority,
    this.finished = false,
  });

  ToDoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    duration = (json['duration']) as int;
    deadline = json['deadline'] == null ? TimestampExtension.fromDateTime((json['deadline'] as int?).toDateTimeUtc) : null;
    priority = (json['priority'] as int).toPriority();
  }

  bool todaysGoal(){
    return dailygoal;
  }

  bool todaysToDo(){
    return !later;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
      'deadline': deadline.toDateTimeUtc.toIso8601String(),
      'dailygoal': dailygoal,
      'later': later,
      'priority': priority?.toInt(),
      'finished': finished,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  bool operator ==(Object other) {
    if(other is ToDoModel){
      var otherToDo = other as ToDoModel;
      return id == otherToDo.id;
    }
    return false;
  }
}
