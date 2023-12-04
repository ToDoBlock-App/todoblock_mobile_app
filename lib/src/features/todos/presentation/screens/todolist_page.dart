import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todoblock_mobile_app/src/common/widget/logo_text.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:todoblock_mobile_app/src/features/todos/presentation/widgets/to_do_card.dart';
import 'package:todoblock_mobile_app/src/features/todos/presentation/widgets/to_do_separator.dart';
import 'package:todoblock_mobile_app/src/features/todos/provider/todos_cubit.dart';
import '../../domain/models/todo_model.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  ToDosCubit toDosCubit = Get.find();

  bool _todosRead = false;

  Widget _buildToDoList(List<ToDoModel> _sortedToDos, List<ToDoModel> _laterToDos) {
    List<Widget> _todoWidgets = [];

    // Adding todos
    for (var todo in _sortedToDos) {
      _todoWidgets.add(ToDoCard(
        title: todo.title ?? "ToDo",
        todo: todo,
        later: false,
      ));
    }

    // Adding a divider if there are any todos for later and now
    if(_laterToDos.isNotEmpty && _sortedToDos.isNotEmpty){
      _todoWidgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        child: ToDoSeparator(
          height: .4,
          color: Colors.black.withOpacity(0.5),
        ),
      ));
    }

    // Adding later todos with line-through style
    for (var laterTodo in _laterToDos) {
      _todoWidgets.add(ToDoCard(
        title: laterTodo.title ?? "Later ToDo",
        todo: laterTodo,
        later: true, // This will apply the line-through style
      ));
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: _todoWidgets,
    );
  }

  @override
  void initState() {
    super.initState();
    toDosCubit.readToDosFromLoggedInUser();
    _todosRead = true;
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              AuthRepository authRepo = Get.find();
              context.loaderOverlay.show();
              authRepo.logout(() => context.go("/list"));
            },
            icon:
            Icon(
              Icons.logout,
              color: Colors.black,
              size: 34,
            ),
          ),
          SizedBox(width: 20,)
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                }else if(state is LoadingToDoData){
                  return Center(child: CircularProgressIndicator(color: Colors.black,));
                }else if(state is ToDosRead){
                  return Column(
                    children: state.goalTodos.map((todo) => ToDoCard(title: todo.title ?? "ToDo", goal: true, todo: todo)).toList(),
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
                  if(state is ReadingToDos){
                    return Center(child: CircularProgressIndicator());
                  }else if(state is LoadingToDoData){
                    return Center(child: CircularProgressIndicator(color: Colors.black,));
                  }else if(state is ToDosRead){
                    return _buildToDoList(state.todayTodos, state.laterTodos);
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
