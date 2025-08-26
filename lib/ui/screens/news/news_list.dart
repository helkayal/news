import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/model/source.dart';
import 'package:news/di/get_it_modules.dart';
import 'package:news/ui/screens/news/article_view_model.dart';
import 'package:news/ui/widgets/article_list.dart';
import 'package:news/ui/widgets/error_view.dart';
import 'package:news/ui/widgets/loading_view.dart';

class NewsList extends StatefulWidget {
  final Source source;
  const NewsList({super.key, required this.source});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late ArticlesViewModel viewModel = getIt();

  @override
  void initState() {
    super.initState();
    viewModel.loadArticles(widget.source.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesViewModel, ArticlesState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingView();
        } else if (state.errorMessage.isNotEmpty) {
          return ErrorView(message: state.errorMessage);
        } else if (state.isEmpty) {
          return ErrorView(message: "No articles available");
        } else {
          return buildArticlesList(state.articles);
        }
      },
    );
  }
}
