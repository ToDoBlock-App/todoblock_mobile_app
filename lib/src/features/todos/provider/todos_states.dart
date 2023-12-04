part of 'todos_cubit.dart';

abstract class ToDosState {}

class ToDoInitState extends ToDosState{}

class ReadingToDos extends ToDosState{}

class LoadingToDoData extends ToDosState{}

class ReadingToDosFailed extends ToDosState{}

class GoalToDoRead extends ToDosState{
  ToDoModel todo;
  GoalToDoRead(this.todo);
}

class SortedToDoRead extends ToDosState{
  ToDoModel todo;
  SortedToDoRead(this.todo);
}

class LaterToDoRead extends ToDosState{
  ToDoModel todo;
  LaterToDoRead(this.todo);
}

class ToDosRead extends ToDosState{
  List<ToDoModel> laterTodos;
  List<ToDoModel> goalTodos;
  List<ToDoModel> todayTodos;

  ToDosRead(this.laterTodos, this.goalTodos, this.todayTodos);
  @override
  String toString() {
    return laterTodos.toString() + " - " + goalTodos.toString() + " - " + todayTodos.toString() + "";
  }
}
