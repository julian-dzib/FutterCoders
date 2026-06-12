// core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme(
      brightness:  Brightness.light,
      primary:     ThemeColors.primary,
      onPrimary:   Colors.white,
      secondary:   ThemeColors.secondary,
      onSecondary: Colors.white,
      error:       ThemeColors.baseErrorColor,
      onError:     Colors.white,
      surface:     ThemeColors.surface,
      onSurface:   ThemeColors.textColor,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),

    //Drawer claro
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThemeColors.drawerLight,
    ),

    //ListTile global — blanco sobre fondo verde
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
    ),

    //ExpansionTile global
    expansionTileTheme: const ExpansionTileThemeData(
      textColor:                Colors.white,
      collapsedTextColor:       Colors.white,
      iconColor:                Colors.white,
      collapsedIconColor:       Colors.white,
      backgroundColor:          Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      tilePadding:              EdgeInsets.symmetric(horizontal: 16),
      childrenPadding:          EdgeInsets.only(left: 40),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme(
      brightness:  Brightness.dark,
      primary:     ThemeColors.primary,
      onPrimary:   Colors.black,
      secondary:   ThemeColors.secondary,
      onSecondary: Colors.black,
      error:       ThemeColors.baseErrorColor,
      onError:     Colors.white,
      surface:     Color(0xFF1E1E1E),
      onSurface:   Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),

    //Drawer oscuro
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThemeColors.drawerDark,
    ),

    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
    ),

    expansionTileTheme: const ExpansionTileThemeData(
      textColor:                Colors.white,
      collapsedTextColor:       Colors.white,
      iconColor:                Colors.white,
      collapsedIconColor:       Colors.white,
      backgroundColor:          Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      tilePadding:              EdgeInsets.symmetric(horizontal: 16),
      childrenPadding:          EdgeInsets.only(left: 40),
    ),
  );
}