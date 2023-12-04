
import 'package:todoblock_mobile_app/src/features/todos/domain/models/todo_model.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/models/workday_model.dart';

abstract class ToDoRepository{

  Stream<List<WorkdayModel>> readUnfinishedToDos();

  Stream<List<ToDoModel>> readToDoUpdates(List<WorkdayModel> workdaysTodo);

  List<ToDoModel> readFinishedToDos();

  Future<ToDoModel> getToDo(ToDoModel toDoModel);

  Future<ToDoModel> createToDo(ToDoModel toDoModel);

  Future<ToDoModel> updateToDo(ToDoModel toDoModel);

  bool deleteToDo(ToDoModel toDoModel);

}