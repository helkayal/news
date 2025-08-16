import 'package:flutter/material.dart';
import 'package:news/data/model/article.dart';
import 'package:news/ui/utils%20/app_routes.dart';
import 'package:news/ui/utils%20/extensions/build_context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleDetailsSheet extends StatelessWidget {
  final Article article;
  const ArticleDetailsSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              CachedNetworkImage(
                imageUrl: article.urlToImage!,
                placeholder: (_, __) => const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
              ),
            const SizedBox(height: 12),
            Text(article.title ?? "", style: context.textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    article.author ?? "Unknown",
                    style: context.textTheme.labelMedium,
                  ),
                ),
                Text(
                  article.publishedAt ?? "",
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              article.description ?? "No description available",
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: context.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () =>
                    Navigator.push(context, AppRoutes.fullArticle(article)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "View Full Article",
                    style: context.textTheme.displayLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
