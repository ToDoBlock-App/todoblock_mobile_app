import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/services/supabase_auth_service.dart';
import 'package:todoblock_mobile_app/src/features/authentication/presentation/screens/login_page.dart';
import 'package:todoblock_mobile_app/src/features/authentication/presentation/screens/register_page.dart';
import 'package:todoblock_mobile_app/src/features/authentication/provider/auth_cubit.dart';
import 'package:todoblock_mobile_app/src/utils/secure_local_storage.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env"); // Choose the file based on the environment
  await Supabase.initialize(
    localStorage: SecureLocalStorage(),
    url: dotenv.env['YOUR_SUPABASE_URL']!,
    anonKey: dotenv.env['YOUR_SUPABASE_ANON_KEY']!,
  );
  manageDependencies();
  runApp(const MyApp());
}

void manageDependencies() {
  Get.lazyPut<AuthRepository>(() => SupabaseAuthService());
  Get.lazyPut(() => AuthCubit(Landing()));
}

final GoRouter _router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's value
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: RegisterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's value
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);


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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ToDoBlock',
      routerConfig: _router,
    );
  }
}

