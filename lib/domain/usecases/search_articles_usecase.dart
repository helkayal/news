import 'package:news/domain/model/article_entity.dart';
import 'package:news/domain/repositories/news_repository.dart';

class SearchArticlesUseCase {
  final NewsRepository repository;

  SearchArticlesUseCase(this.repository);

  Future<List<ArticleEntity>> execute(String query) {
    return repository.searchArticles(query);
  }
}
