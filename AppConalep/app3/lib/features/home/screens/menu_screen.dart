import 'package:app3/core/resources/app_resources.dart';
import 'package:app3/core/routes/app_routes.dart';
import 'package:app3/core/theme/app_styles/text_styles.dart';
import 'package:app3/features/home/widgets/drawer_expansion_item.dart';
import 'package:app3/features/home/widgets/drawer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuScreen extends StatefulWidget {
  final Widget child;
  const MenuScreen({super.key, required this.child});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
   /// Controla abrir/cerrar el AdvancedDrawer.
  final AdvancedDrawerController _drawerController = AdvancedDrawerController();

  @override
  void dispose() {
    /// Libera el controller al destruir el widget.
    _drawerController.dispose();
    super.dispose();
  }

  /// Retorna el título del AppBar según la ruta activa.
  ///
  /// Usa [matchedLocation] para obtener el path exacto
  /// sin query params ni fragmentos.
  String _getTitleForRoute(BuildContext context) {
    final l10n     = AppLocalizations.of(context)!;
    final location = GoRouterState.of(context).matchedLocation;

    switch (location) {
      case AppRoutes.dashboard: return l10n.dashboard;
      case AppRoutes.settings:  return l10n.settings;
      default:                  return l10n.dashboard;
    }
  }

  /// Navega a [route] y cierra el drawer.
  /// Centraliza la lógica para no repetirla en cada ítem.
  void _goTo(BuildContext context, String route) {
    context.go(route);
    _drawerController.hideDrawer();
  }

  
  @override
  Widget build(BuildContext context) {
    // Traducciones
    //final l10n = AppLocalizations.of(context)!;
    // Colores del tema para el drawer
    //final drawerColor = Theme.of(context).drawerTheme.backgroundColor
    //                    ?? Theme.of(context).colorScheme.primary;
    
    final l10n = AppLocalizations.of(context)!;

    /// Color del drawer según el tema activo (claro/oscuro).
    final Color drawerColor =
        Theme.of(context).drawerTheme.backgroundColor ??
        Theme.of(context).colorScheme.primary;

    return AdvancedDrawer(
      // Controlador del drawer
      controller: _drawerController,
      // Color del backdrop detrás del drawer      backdropColor: drawerColor,
      // Sombra del drawer
      backdrop: Container(
        // El contenedor del backdrop se extiende a toda la pantalla
        width: double.infinity,
        // El height se extiende a toda la pantalla para cubrirla completamente
        height: double.infinity,
        //Color del backdrop viene del tema
        color: drawerColor,
      ),

      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,

      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),

      // Drawer ────────────────────────────────────────────────
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),

                        // ── Perfil ───────────────────────────────

                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(AppResources.profile),
                        ),

                        const SizedBox(height: 40),

                        // ── Ítems ───────────────────────────────

                        DrawerItem(
                          icon:  AppResources.home,
                          title: l10n.dashboard,
                          onTap: () => _goTo(context, AppRoutes.dashboard),
                        ),

                        DrawerItem(
                          icon:  AppResources.setting,
                          title: l10n.settings,
                          onTap: () => _goTo(context, AppRoutes.settings),
                        ),


                        DrawerExpansionItem(
                          icon:  AppResources.menu,
                          title: l10n.options,
                          children: [
                            ListTile(
                              title: Text('${l10n.subMenu} 1'),
                              onTap: () => _drawerController.hideDrawer(),
                            ),
                            ListTile(
                              title: Text('${l10n.subMenu} 2'),
                              onTap: () => _drawerController.hideDrawer(),
                            ),
                          ],
                        ),

                        const Expanded(flex: 1, child: SizedBox()),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            '${l10n.latestVersion} 1.0',
                            style: AppTextStyles.caption(context)
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),

      //Contenido principal ───────────────────────────────────
      child: Scaffold(
        appBar: AppBar(
          title: Text(_getTitleForRoute(context)),
          leading: IconButton(
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _drawerController,
              builder: (_, value, __) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  value.visible ? Icons.close : Icons.menu,
                  key: ValueKey(value.visible),
                ),
              ),
            ),
            onPressed: () => _drawerController.showDrawer(),
          ),
        ),
        //ShellRoute inyecta aquí cada pantalla
        body: widget.child,
      ),
    );
  }
}