import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/models/todo_model.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/models/workday_model.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/repositories/todo_repo.dart';

class SupabaseToDoService extends ToDoRepository{

  final supabase = Supabase.instance.client;


  @override
  Stream<List<WorkdayModel>> readUnfinishedToDos() {
      return supabase
          .from("workdays")
          .stream(primaryKey: ['id'])
          .eq("finished", false)
          .asyncMap((unfinishedToDos) async {
            List<WorkdayModel> workdayTodos = [];
            for(Map<String, dynamic> rawWorkday in unfinishedToDos){
              var workday = WorkdayModel(ToDoModel(id: rawWorkday['todo_id']), rawWorkday['goal'], rawWorkday['later'], rawWorkday['finished'], DateTime.parse(rawWorkday['date']));
              workdayTodos.add(workday);
            }
            return workdayTodos;
      });
  }

  @override
  Stream<List<ToDoModel>> readToDoUpdates(List<WorkdayModel> workdaysTodo) {
    var todosUUID = workdaysTodo.map((workdayTodo) => workdayTodo.refToDo.id).toList();

    return supabase
        .from("todos")
        .stream(primaryKey: ['id'])
        .inFilter("id", todosUUID)
        .map((rawTodos){
          //print(rawTodos);
          List<ToDoModel> todos = [];
          for(Map<String, dynamic> rawTodo in rawTodos){
            ToDoModel todo = ToDoModel.fromJson(rawTodo);
            WorkdayModel refWorkday = workdaysTodo.firstWhere((workdayTodo) => workdayTodo.refToDo.id == todo.id);
            todo.finished = refWorkday.finished;
            todo.later = refWorkday.later;
            todo.dailygoal = refWorkday.dailygoal;
            todos.add(todo);
          }
          return todos;
    });
  }

  @override
  List<ToDoModel> readFinishedToDos() {
    // TODO: implement readFinishedToDos
    throw UnimplementedError();
  }

  @override
  Future<ToDoModel> getToDo(ToDoModel toDoModel) async {
    var rawTodo = await supabase.from("todos").select('*').eq('id', toDoModel.id);
    return ToDoModel.fromJson(rawTodo[0]);
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

  @override
  bool deleteToDo(ToDoModel toDoModel) {
    // TODO: implement deleteToDo
    throw UnimplementedError();
  }

}