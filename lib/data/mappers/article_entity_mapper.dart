import 'package:news/data/model/article.dart';
import 'package:news/domain/model/article_entity.dart';

class ArticleMapper {
  ArticleEntity fromDataModel(Article article) {
    return ArticleEntity(
      title: article.title ?? "",
      description: article.description ?? "",
      url: article.url ?? "",
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
    );
  }

  List<ArticleEntity> fromDataModels(List<Article> articles) {
    return articles.map(fromDataModel).toList();
  }
}
