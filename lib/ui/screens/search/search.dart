import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/ui/screens/search/search_view_model.dart';
import 'package:news/ui/widgets/app_scaffold.dart';
import 'package:news/ui/widgets/article_list.dart';
import 'package:news/ui/widgets/error_view.dart';
import 'package:news/ui/widgets/loading_view.dart';

class SearchNews extends StatelessWidget {
  const SearchNews({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocBuilder<SearchViewModel, SearchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingView();
          } else if (state.errorMessage.isNotEmpty) {
            return ErrorView(message: state.errorMessage);
          } else if (state.isEmpty) {
            return ErrorView(message: "No Search Results Found");
          } else {
            return buildArticlesList(state.articles);
          }
        },
      ),
      appBarTitle: "Search",
      isSearch: true,
    );
  }
}
