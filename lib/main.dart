import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news/data/utils/hive_adapter/source_adapter.dart';
import 'package:news/ui/providers/theme_provider.dart';
import 'package:news/ui/screens/home/home.dart';
import 'package:news/ui/utils%20/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  Hive.initFlutter();
  Hive.registerAdapter(SourceAdapter());
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeProvider themeProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeProvider = Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: Home(),
    );
  }
}
