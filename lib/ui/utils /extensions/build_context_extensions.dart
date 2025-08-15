import 'package:flutter/material.dart';
import 'package:news/ui/providers/theme_provider.dart';
import 'package:provider/provider.dart';

extension BuildContextExtensions on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;

  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get themeData => Theme.of(this);

  ThemeProvider get themeProvider => Provider.of(this, listen: false);

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}
