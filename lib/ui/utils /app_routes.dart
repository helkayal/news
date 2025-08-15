import 'package:flutter/material.dart';
import 'package:news/ui/model/category_dm.dart';
import 'package:news/ui/screens/home/home.dart';
import 'package:news/ui/screens/news/news.dart';
import 'package:news/ui/screens/splash/splash.dart';

abstract final class AppRoutes {
  static Route get splash => MaterialPageRoute(builder: (_) => Splash());

  static Route get home => MaterialPageRoute(builder: (_) => Home());

  static Route news(CategoryDM category) =>
      MaterialPageRoute(builder: (_) => News(categoryDM: category));
}
