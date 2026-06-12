// features/menu/widgets/drawer_expansion_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Ítem expandible del drawer lateral.
///
/// El color del ícono se obtiene del [listTileTheme],
/// igual que [DrawerItem], para mantener consistencia visual.
/// Los estilos del [ExpansionTile] vienen del [expansionTileTheme]
/// definido en [AppTheme].
class DrawerExpansionItem extends StatelessWidget {
  /// Ruta del asset SVG del ícono.
  final String icon;

  /// Texto visible del ítem principal.
  final String title;

  /// Widgets hijos visibles al expandir.
  final List<Widget> children;

  const DrawerExpansionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    /// Usa [listTileTheme] igual que DrawerItem
    /// para consistencia — ambos están en el mismo drawer.
    final Color iconColor =
        Theme.of(context).listTileTheme.iconColor ?? Colors.white;

    return ExpansionTile(
      leading: SvgPicture.asset(
        icon,
        width:  24,
        height: 24,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
      title:    Text(title),
      children: children,
    );
  }
}