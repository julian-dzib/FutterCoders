// features/menu/widgets/drawer_item_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Ítem estándar del drawer lateral.
///
/// El color del ícono y del texto se obtienen automáticamente
/// del [listTileTheme] definido en [AppTheme], por lo que
/// no necesita recibir colores como parámetros.
class DrawerItem extends StatelessWidget {
  /// Ruta del asset SVG del ícono.
  final String icon;

  /// Texto visible del ítem.
  final String title;

  /// Acción al tocar el ítem.
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    /// Lee el color del ícono desde el tema.
    /// El [listTileTheme] en [AppTheme] lo define como blanco
    /// tanto en tema claro como oscuro para el drawer.
    final Color iconColor =
        Theme.of(context).listTileTheme.iconColor ?? Colors.white;

    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width:  24,
        height: 24,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}