import 'package:news/domain/model/article_entity.dart';
import 'package:news/domain/model/source.dart';

abstract class NewsRepository {
  Future<List<Source>?> loadSources(String categoryId);
  Future<List<ArticleEntity>?> getArticles(String sourceId);
  Future<List<ArticleEntity>> searchArticles(String query);
}
