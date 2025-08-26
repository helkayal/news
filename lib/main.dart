import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/data/model/article.dart';
import 'package:news/data/utils/hive_adapter/article_adapter.dart';
import 'package:news/data/utils/hive_adapter/source_adapter.dart';
import 'package:news/di/get_it_modules.dart';
import 'package:news/ui/providers/theme_provider.dart';
import 'package:news/ui/screens/home/home.dart';
import 'package:news/ui/screens/search/search_view_model.dart';
import 'package:news/ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SourceAdapter());
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Article>("articles");

  configureDependcies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        BlocProvider<SearchViewModel>(create: (_) => SearchViewModel(getIt())),
      ],
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: Home(),
    );
  }
}
