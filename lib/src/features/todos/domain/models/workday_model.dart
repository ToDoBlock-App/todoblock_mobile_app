import 'package:todoblock_mobile_app/src/features/todos/domain/models/todo_model.dart';

class WorkdayModel {
  ToDoModel refToDo;
  bool dailygoal;
  bool later;
  bool finished;
  DateTime date;

  WorkdayModel(this.refToDo, this.dailygoal, this.later, this.finished, this.date);


}