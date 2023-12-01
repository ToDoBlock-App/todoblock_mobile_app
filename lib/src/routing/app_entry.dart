import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todoblock_mobile_app/src/common/widget/splash_screen.dart';
import 'package:todoblock_mobile_app/src/features/authentication/presentation/screens/home_page.dart';
import 'package:todoblock_mobile_app/src/features/blocking/presentation/screens/blocking_page.dart';
import 'package:todoblock_mobile_app/src/features/blocking/presentation/screens/settings_blocking_page.dart';
import 'package:todoblock_mobile_app/src/features/chatbot/presentation/screens/chatbot_page.dart';
import 'package:todoblock_mobile_app/src/features/settings/presentation/screens/settings_page.dart';
import 'package:todoblock_mobile_app/src/features/todoblocks/presentation/screens/distracted_page.dart';
import 'package:todoblock_mobile_app/src/features/todoblocks/presentation/screens/schedule_todo_page.dart';
import 'package:todoblock_mobile_app/src/features/todoblocks/presentation/screens/todoblock_page.dart';
import 'package:todoblock_mobile_app/src/features/todos/presentation/screens/create_todo_page.dart';
import 'package:todoblock_mobile_app/src/features/todos/presentation/screens/details_todo_page.dart';
import 'package:todoblock_mobile_app/src/features/todos/presentation/screens/todolist_page.dart';

import '../common/singleton/session_data.dart';
import '../features/authentication/presentation/screens/login_page.dart';
import '../features/authentication/presentation/screens/register_page.dart';

part 'routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // or Brightness.dark
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ToDoBlock',
        routerConfig: _router,
      ),
    );
  }
}

