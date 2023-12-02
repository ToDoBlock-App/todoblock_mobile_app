part of 'app_entry.dart';

final GoRouter _router = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen()
    ),
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
    GoRoute(
      path: "/",
      routes: _protectedRoutes,
      redirect: (BuildContext context, GoRouterState state) async {
        final sessionData = SessionStorageManager();
        if (await sessionData.sessionIsValid()) {
          return null;
        }
        return '/login';
      },
    ),
  ],
);

final _protectedRoutes = [
    ShellRoute(
      builder: (context, state, child) => HomePage(child),
      routes: [
        GoRoute(
          path: "list",
          builder: (context, state) => ToDoListPage()
        ),
        GoRoute(
          path: "block",
            builder: (context, state) => ToDoBlockPage()
        )
      ]
    ),
    GoRoute(
        path: "create",
        builder: (context, state) => CreateToDoPage()
    ),
    GoRoute(
        path: "schedule",
        builder: (context, state) => ScheduleToDoPage()
    ),
    GoRoute(
        path: "distracted",
        builder: (context, state) => DistractedPage()
    ),
    GoRoute(
        path: "details/:id",
        builder: (context, state) {
          final id = state.pathParameters['id']; // Get "id" param from URL
          return DetailsToDoPage(id!);
        }
    ),
    GoRoute(
        path: "chatbot",
        builder: (context, state) => ChatBotPage()
    ),
    GoRoute(
        path: "settings",
        builder: (context, state) => SettingsPage()
    ),
    GoRoute(
        path: "settings/blocking",
        builder: (context, state) => SettingsBlockingPage()
    ),
    GoRoute(
        path: "blocking/:app",
        builder: (context, state) {
          final app = state.pathParameters['app']; // Get "id" param from URL
          return BlockingPage(app!);
        }
    )
];