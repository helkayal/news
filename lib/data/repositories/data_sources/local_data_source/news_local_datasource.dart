import 'package:news/data/model/article.dart';
import 'package:news/data/model/source_response.dart';

abstract class NewsLocalDataSource {
  Future<List<SourceResponse>?> loadSources(String categoryId);
  Future<void> saveSources(String category, List<SourceResponse> sources);

  Future<List<Article>?> loadArticles(String sourceId);
  Future<void> saveArticles(String sourceId, List<Article> articles);
  Future<List<Article>> searchArticles(String query, {String? sourceId});
  Future<void> cacheArticles(List<Article> articles);
}
