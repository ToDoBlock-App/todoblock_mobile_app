import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/services/supabase_auth_service.dart';
import 'package:todoblock_mobile_app/src/features/authentication/provider/auth_cubit.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/repositories/todo_repo.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/services/supabase_todo_service.dart';
import 'package:todoblock_mobile_app/src/features/todos/provider/todos_cubit.dart';
import 'package:todoblock_mobile_app/src/routing/app_entry.dart';
import 'package:todoblock_mobile_app/src/utils/secure_local_storage.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Choose the file based on the environment
  await Supabase.initialize(
    localStorage: SecureLocalStorage(),
    url: dotenv.env['YOUR_SUPABASE_URL']!,
    anonKey: dotenv.env['YOUR_SUPABASE_ANON_KEY']!,
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  manageDependencies();
  runApp(const MyApp());
}

void manageDependencies() {
  Get.lazyPut<AuthRepository>(() => SupabaseAuthService());
  Get.lazyPut(() => AuthCubit(Landing()));

  Get.lazyPut<ToDoRepository>(() => SupabaseToDoService());
  Get.lazyPut<ToDosCubit>(() => ToDosCubit(ToDoInitState()));
}