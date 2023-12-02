part of 'todos_cubit.dart';

abstract class ToDosState {}

class ToDoInitState extends ToDosState{}

class ReadingToDos extends ToDosState{}

class ReadingToDosFailed extends ToDosState{}

class ToDosRead extends ToDosState{
  List<List<ToDoModel>> todos;
  ToDosRead(this.todos);
}

