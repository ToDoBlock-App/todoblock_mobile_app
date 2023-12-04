import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/repositories/todo_repo.dart';

import '../domain/models/todo_model.dart';

part 'todos_states.dart';

class ToDosCubit extends Cubit<ToDosState>{

  ToDoRepository toDoRepository = Get.find();
  Stream<List<ToDoModel>> todoUpdates = Stream.empty();

  ToDosCubit(super.initialState);

  void readToDosFromLoggedInUser(){
    emit(ReadingToDos());
    toDoRepository.readUnfinishedToDos().listen((workdaysTodo) {
      if(workdaysTodo.isEmpty){
        emit(ReadingToDosFailed());
      }

      todoUpdates = toDoRepository.readToDoUpdates(workdaysTodo);
      _listenToTodoChanges();

      }, onError: (obj) {
      print(obj);
      emit(ReadingToDosFailed());
    });
  }

  void _listenToTodoChanges(){
    emit(LoadingToDoData());
    todoUpdates.listen((todoChanges) {
      var newStateChange = ToDosRead([], [], []);
      for(ToDoModel todo in todoChanges){
        if(todo.todaysGoal()){
          newStateChange.goalTodos.add(todo);
        }else{
          if(todo.todaysToDo()){
            newStateChange.todayTodos.add(todo);
          }else {
            newStateChange.laterTodos.add(todo);
          }
        }
      }
      print("CUBIT: " + newStateChange.toString());
      emit(newStateChange);
    });
  }

}