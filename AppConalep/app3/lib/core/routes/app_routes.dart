// core/routes/app_routes.dart

/// Define todas las rutas de la aplicación.
///
/// Jerarquía:
/// /
/// └── /menu                  ← ShellRoute (drawer compartido)
///       ├── /menu/dashboard  ← vista principal
///       ├── /menu/settings   ← configuración
///       └── /menu/chatbot    ← chatbot
///
/// Las rutas hijas de ShellRoute DEBEN tener el prefijo /menu
/// para que GoRouter sepa que pertenecen al mismo shell.
class AppRoutes {

  /// Raíz de la app.
  /// No muestra pantalla — solo redirige a [dashboard].
  /// Cuando agregues login, aquí decides a dónde ir
  /// según si hay sesión activa o no.
  static const String root = '/';

  /// Prefijo del ShellRoute.
  /// No se navega directamente a esta ruta.
  /// Existe para agrupar las rutas que comparten el drawer.
  static const String menu = '/menu';

  /// Vista principal de la app.
  /// Primera pantalla visible al iniciar.
  static const String dashboard = '/menu/dashboard';

  /// Configuración de la app.
  static const String settings = '/menu/settings';

}
/*class AppRoutes {
  static const String home     = '/home';
  static const String settings = '/settings';
  static const String dashboard = '/dashboard';
  static const String chatbot   = '/chatbot';
}*/