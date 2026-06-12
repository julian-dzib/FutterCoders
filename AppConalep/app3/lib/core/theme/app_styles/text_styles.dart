// core/theme/text_styles.dart
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle base(BuildContext context) => TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontFamily: 'Lato',
      );

  static TextStyle title(BuildContext context) =>
      base(context).copyWith(fontSize: 20, fontWeight: FontWeight.bold);

  static TextStyle subtitle(BuildContext context) =>
      base(context).copyWith(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle body(BuildContext context) =>
      base(context).copyWith(fontSize: 16);

  static TextStyle caption(BuildContext context) =>
      base(context).copyWith(fontSize: 12);
}