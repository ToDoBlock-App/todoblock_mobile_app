import 'package:todoblock_mobile_app/src/features/todos/domain/models/timestamp_extension.dart';
import 'priority_extension.dart';

class ToDoModel {
  int? id;
  String? title;
  String? description;
  int? duration;
  int? deadline;
  List<int>? dailygoal;
  Priority? priority;
  int? finished;

  ToDoModel({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.deadline,
    this.dailygoal,
    this.priority,
    this.finished,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    List<int> dailygoal = [];

    if(json['dailygoal'] != null){
      var jsonList = [];
      for(dynamic goal in json['dailygoal']){
        dailygoal.add(DateTime.parse(goal).millisecondsSinceEpoch);
      }
      // var jsonList = json['dailygoal']?.cast<int>();
      // for(int element in jsonList){
      //   dailygoal.add(TimestampExtension.fromDateTime((element).toDateTimeUtc));
      // }
    }

    return ToDoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duration: (json['duration']) as int,
      deadline:  json['deadline'] == null ? TimestampExtension.fromDateTime((json['deadline'] as int?).toDateTimeUtc) : null,
      dailygoal: dailygoal.isEmpty? dailygoal : null,
      priority: (json['priority'] as int).toPriority(),
      finished:  json['finished'] == null ? TimestampExtension.fromDateTime((json['finished'] as int?).toDateTimeUtc) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
      'deadline': deadline,
      'dailygoal': dailygoal,
      'priority': priority?.toInt(),
      'finished': finished,
    };
  }
}
