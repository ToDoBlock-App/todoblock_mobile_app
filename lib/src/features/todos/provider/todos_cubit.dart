import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todoblock_mobile_app/src/common/singleton/session_storage.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/repositories/todo_repo.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/services/supabase_todo_service.dart';

import '../domain/models/todo_model.dart';

part 'todos_states.dart';

class ToDosCubit extends Cubit<ToDosState>{

  ToDoRepository toDoRepository = Get.find();

  ToDosCubit(super.initialState);

  Future<void> readToDosFromLoggedInUser() async{
    emit(ReadingToDos());

    var user = SessionStorageManager().currentUser;

    toDoRepository.readToDos(user).listen((todos) {
      print(todos);
      emit(ToDosRead(todos));
    }, onError: (obj) {
      print(obj);
      emit(ReadingToDosFailed());
    });
  }

}