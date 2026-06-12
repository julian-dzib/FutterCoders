import 'package:app3/features/home/screens/dashboard_screen.dart';
import 'package:app3/features/home/screens/menu_screen.dart';
import 'package:app3/features/home/screens/settings.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(

    /// Siempre arranca en raíz.
    /// El redirect de [root] decide a dónde ir.
    initialLocation: AppRoutes.root,

    routes: [

      /// Ruta raíz — no muestra pantalla propia.
      ///
      /// [redirect] se ejecuta antes de mostrar cualquier UI.
      /// Ahora manda directo a dashboard.
      /// Cuando tengas login, aquí preguntas si hay sesión:
      ///
      /// final hasSession = AuthService.isLoggedIn;
      /// return hasSession ? AppRoutes.dashboard : AppRoutes.login;
      GoRoute(
        path: AppRoutes.root,
        redirect: (context, state) => AppRoutes.dashboard,
      ),

      /// ShellRoute — agrupa las rutas que comparten el drawer.
      ///
      /// GoRouter llama a este builder cada vez que el usuario
      /// navega a cualquier ruta hija, pasando la pantalla activa
      /// como [child].
      ///
      /// Ejemplo:
      ///   context.go(AppRoutes.settings)
      ///   → GoRouter construye: MenuScreen(child: SettingsScreen())
      ///   → El drawer permanece, solo cambia el body
      ShellRoute(
        builder: (context, state, child) {
          /// [child] es la pantalla activa.
          /// HombeScreen o MenuScreen lo coloca en su body.
          return MenuScreen(child: child);
        },

        /// Rutas hijas — todas con prefijo /menu
        /// para pertenecer a este ShellRoute.
        routes: [

          /// Vista principal
          GoRoute(
            path: AppRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              /// [NoTransitionPage] elimina la animación de transición.
              /// Las secciones del menú no necesitan animación —
              /// es un cambio de sección, no una navegación profunda.
              child: DashboardScreen(),
            ),
          ),

          /// Configuración
          GoRoute(
            path: AppRoutes.settings,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}




/*class AppRouter {
 static final GoRouter router = GoRouter(
    //Ruta inicial de la aplicación
    initialLocation: AppRoutes.home,
    routes: [

      // ShellRoute es una ruta que envuelve a otras rutas, permitiendo compartir una estructura común (como un Scaffold) entre varias pantallas.
      // En este caso, HomeScreen actúa como un contenedor para las rutas de DashboardScreen y SettingsScreen, lo que permite mantener una barra de navegación o cualquier otro elemento común mientras se navega entre estas pantallas.
      // El builder de ShellRoute 
      // recibe el contexto, el estado de la ruta y
      // el child, que es la pantalla activa que se muestra dentro del HomeScreen.
      ShellRoute(
      //HomeScreen recibe el child — la pantalla activa
      //context -> contexto actual
      //state   -> estado de navegación
      //child   -> ruta/pantalla activa
        builder: (context, state, child) => HomeScreen(child: child),        
        //Rutas hijas del shell route
        //Estas rutas se mostrarán dentro del HomeScreen, 
        //permitiendo compartir la estructura común definida en HomeScreen mientras se navega
        //entre DashboardScreen y SettingsScreen.
        routes: [
          GoRoute(
            //
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            )
            //Sin animación de transición entre pantallas
            /*pageBuilder: (context, state) => CustomTransitionPage(
              child: DashboardScreen(), 
              transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) { 
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),*/
          ),
          GoRoute(
            path: AppRoutes.settings,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}*/