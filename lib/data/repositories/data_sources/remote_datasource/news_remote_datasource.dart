import 'package:news/data/model/article.dart';

import '../../../model/source_response.dart';

abstract class NewsRemoteDataSource {
  Future<List<SourceResponse>?> loadSources(String categoryId);
  Future<List<Article>?> loadArticles(String sourceId);
  Future<List<Article>> searchArticles(String query);
}
