import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/di/get_it_modules.dart';
import 'package:news/domain/model/source.dart';
import 'package:news/ui/model/category_dm.dart';
import 'package:news/ui/screens/news/news_list.dart';
import 'package:news/ui/utils%20/extensions/build_context_extensions.dart';
import 'package:news/ui/widgets/app_scaffold.dart';
import 'package:news/ui/widgets/error_view.dart';
import 'package:news/ui/widgets/loading_view.dart';

import 'news_view_model.dart';

class News extends StatefulWidget {
  final CategoryDM categoryDM;

  const News({super.key, required this.categoryDM});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late NewsViewModel viewModel = getIt();

  @override
  void initState() {
    super.initState();
    viewModel.loadSources(widget.categoryDM.id);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocBuilder<NewsViewModel, NewsState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return ErrorView(message: state.errorMessage);
          } else if (state.sources.isNotEmpty) {
            return buildTabsList(context, state.sources);
          } else {
            return Center(child: LoadingView());
          }
        },
      ),
      appBarTitle: widget.categoryDM.id,
    );
  }

  Widget buildTabsList(BuildContext context, List<Source> sources) {
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            dividerColor: Colors.transparent,
            labelStyle: context.textTheme.bodyMedium,
            unselectedLabelStyle: context.textTheme.bodySmall,
            tabAlignment: TabAlignment.start,
            indicatorColor: context.secondaryColor,
            tabs: sources.map(mapSourceToTab).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: sources
                  .map((source) => NewsList(source: source))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget mapSourceToTab(Source source) {
    return Tab(text: source.name);
  }
}
