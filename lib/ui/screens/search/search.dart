import 'package:flutter/material.dart';
import 'package:news/ui/widgets/app_scaffold.dart';

class SearchNews extends StatelessWidget {
  const SearchNews({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(child: Text("Search News Screen")),
      appBarTitle: "Search",
      isSearch: true,
    );
  }
}
