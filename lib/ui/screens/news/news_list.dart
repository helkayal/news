import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/data/api_manager.dart';
import 'package:news/data/model/article.dart';
import 'package:news/data/model/source.dart';
import 'package:news/ui/screens/article/full_article.dart';
import 'package:news/ui/screens/news/widgets/article_details_sheet.dart';
import 'package:news/ui/utils%20/extensions/build_context_extensions.dart';
import 'package:news/ui/widgets%20/error_view.dart';
import 'package:news/ui/widgets%20/loading_view.dart';

class NewsList extends StatelessWidget {
  final Source source;
  const NewsList({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.instance.loadArticles(source.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorView(message: snapshot.error.toString());
        } else if (snapshot.hasData) {
          var articles = snapshot.data!;
          return buildArticlesList(articles);
        } else {
          return LoadingView();
        }
      },
    );
  }

  Widget buildArticlesList(List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) =>
          buildArticleItem(context, articles[index]),
    );
  }

  Widget buildArticleItem(BuildContext context, Article article) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (_) => ArticleDetailsSheet(article: article),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: context.secondaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              placeholder: (_, __) => LoadingView(),
              errorWidget: (_, __, ___) => Icon(Icons.error),
              height: context.height * .25,
            ),
            Text(article.title ?? "", style: context.textTheme.bodyMedium),
            Row(
              children: [
                Expanded(
                  child: Text(
                    article.author ?? "",
                    style: context.textTheme.labelMedium,
                  ),
                ),
                Text(
                  article.publishedAt ?? "",
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
