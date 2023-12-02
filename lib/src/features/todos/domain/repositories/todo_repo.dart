
import 'package:todoblock_mobile_app/src/features/todos/domain/models/todo_model.dart';

import '../../../authentication/domain/models/user_model.dart';

abstract class ToDoRepository{

  Stream<dynamic> readToDos(UserModel userModel);

  Future<ToDoModel> getToDo(ToDoModel toDoModel);

  Future<ToDoModel> createToDo(ToDoModel toDoModel);

  Future<ToDoModel> updateToDo(ToDoModel toDoModel);

  bool deleteToDo(ToDoModel toDoModel);

}