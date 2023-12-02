import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todoblock_mobile_app/src/common/singleton/session_storage.dart';
import 'package:todoblock_mobile_app/src/common/widget/logo_text.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/repositories/todo_repo.dart';
import 'package:todoblock_mobile_app/src/features/todos/presentation/widgets/to_do_card.dart';
import 'package:todoblock_mobile_app/src/features/todos/presentation/widgets/to_do_separator.dart';
import 'package:todoblock_mobile_app/src/features/todos/provider/todos_cubit.dart';

import '../../../authentication/domain/models/user_model.dart';
import '../../domain/models/todo_model.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
 // final UserModel user = SessionStorageManager().currentUser;

  ToDoRepository todoRepo = Get.find();
  ToDosCubit toDosCubit = Get.find();

  Widget _buildToDoList(List<ToDoModel> todos, List<ToDoModel> laterTodos) {
    List<Widget> todoWidgets = [];

    // Adding todos
    for (var todo in todos) {
      todoWidgets.add(ToDoCard(
        title: todo.title ?? "ToDo",
        todo: todo,
        later: false,
      ));
    }

    // Adding a divider if there are any later todos
    if (laterTodos.isNotEmpty) {
      todoWidgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        child: ToDoSeparator(
          height: .4,
          color: Colors.black.withOpacity(0.5),
        ),
      ));
    }

    // Adding later todos with line-through style
    for (var laterTodo in laterTodos) {
      todoWidgets.add(ToDoCard(
        title: laterTodo.title ?? "Later ToDo",
        todo: laterTodo,
        later: true, // This will apply the line-through style
      ));
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: todoWidgets,
    );
  }


  @override
  void initState() {
    super.initState();
    if(context.loaderOverlay.visible){
      context.loaderOverlay.hide();
    }

    toDosCubit.readToDosFromLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
   // final String uuid = user.uuid ?? "Error";

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: LogoText(
            text: 'ToDoBlock',
            animation: false,
            fontSize: 48,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {  },
            icon:
            Icon(
              Icons.settings,
              color: Colors.black,
              size: 34,
            ),
          ),
          SizedBox(width: 20,)
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark   ,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/TDB_SplashScreen.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            SizedBox(height: Get.height*0.11,),
            Container(
              width: double.infinity,
              height: 35,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Jetziger ToDoBlock: ",
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Text(
                      "Erste ToDo",
                    style: GoogleFonts.urbanist(
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  )
                ],
              )
            ),
            SizedBox(height: 10,),
            ToDoCard(title: "Neue ToDo erstellen", action: true,),
            BlocBuilder<ToDosCubit, ToDosState>(
              bloc: toDosCubit,
              builder: (context, state){
                print(state);
                if(state is ReadingToDos){
                  return Center(child: CircularProgressIndicator());
                }

                if(state is ToDosRead){
                  var todos = state.todos[0];
                  //List<ToDoModel> dailyGoals = todos.take(3).toList();
                  //Get Daily Goals Only
                  return Column(
                    children: todos.map((todo) => ToDoCard(title: todo.title ?? "ToDo", goal: true, todo: todo)).toList(),
                  );
                }

                return Container();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(
                thickness: .4,
                color: Colors.black.withOpacity(.8),
              ),
            ),
            Expanded(
              child: BlocBuilder<ToDosCubit, ToDosState>(
                bloc: toDosCubit,
                builder: (context, state){
                  print(state);
                  if(state is ReadingToDos){
                    return Center(child: CircularProgressIndicator());
                  }

                  if(state is ToDosRead){
                    var laterTodos = state.todos[1];
                    var todos = state.todos[2];
                    return _buildToDoList(todos, laterTodos);
                    // return ListView.builder(
                    //   padding: EdgeInsets.zero,
                    //   itemCount: todos.length,
                    //   itemBuilder: (context, index) {
                    //     var todo = todos[index];
                    //     var title = todo.title;
                    //     if(title == null){
                    //       return null;
                    //     }
                    //     return ToDoCard(title: title, todo: todo,);
                    //   }
                    // );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
