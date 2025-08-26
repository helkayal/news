import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/domain/model/article_entity.dart';
import 'package:news/ui/screens/news/widgets/article_details_sheet.dart';
import 'package:news/ui/utils/extensions/build_context_extensions.dart';
import 'package:news/ui/widgets/loading_view.dart';

Widget buildArticlesList(List<ArticleEntity> articles) {
  return ListView.builder(
    itemCount: articles.length,
    itemBuilder: (context, index) => buildArticleItem(context, articles[index]),
  );
}

Widget buildArticleItem(BuildContext context, ArticleEntity article) {
  final imageUrl = article.urlToImage;
  final hasValidImage = imageUrl != null && imageUrl.isNotEmpty;

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
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: context.secondaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          hasValidImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (_, __) => const LoadingView(),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                  height: context.height * .25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: context.height * .25,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: const Icon(Icons.error, size: 40),
                ),
          Text(article.title, style: context.textTheme.bodyMedium),
          Text(article.publishedAt ?? "", style: context.textTheme.labelMedium),
        ],
      ),
    ),
  );
}
