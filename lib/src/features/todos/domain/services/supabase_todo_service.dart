import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/models/todo_model.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/repositories/todo_repo.dart';

class SupabaseToDoService extends ToDoRepository{

  final supabase = Supabase.instance.client;

  @override
  bool deleteToDo(ToDoModel toDoModel) {
    // TODO: implement deleteToDo
    throw UnimplementedError();
  }

  //3 Listen?
  //ToDo Liste mit Daily Goals
  //ToDo Liste sortiert nach Prios
  //ToDo Liste mit do it later true

  @override
  Stream<dynamic> readToDos(UserModel userModel) {
    String? uuid = userModel.uuid;
    return supabase
        .from("todos")
        .stream(primaryKey: ['id'])
        .order("priority", ascending: false)
        .eq("user_id", uuid)
        .map((data){
          //print(data);
          List<ToDoModel> resultOpen = [];


          List<ToDoModel> dailyGoals = [];
          List<ToDoModel> laterToDos = [];
          List<ToDoModel> sortedToDos = [];
          for(Map<String, dynamic> todoData in data){
            if(todoData['dailygoal'] != null && true){//Todays Date in List
              dailyGoals.add(ToDoModel.fromJson(todoData));
              continue;
            }

            if(todoData['do_it_later'] == true){
              laterToDos.add(ToDoModel.fromJson(todoData));
              continue;
            }

            sortedToDos.add(ToDoModel.fromJson(todoData));
          }

          return [dailyGoals, laterToDos, sortedToDos];
    });
  }

  @override
  Future<ToDoModel> getToDo(ToDoModel toDoModel) {
    // TODO: implement getToDo
    throw UnimplementedError();
  }

  @override
  Future<ToDoModel> createToDo(ToDoModel toDoModel) {
    // TODO: implement createToDo
    throw UnimplementedError();
  }

  @override
  Future<ToDoModel> updateToDo(ToDoModel toDoModel) {
    // TODO: implement updateToDo
    throw UnimplementedError();
  }

}