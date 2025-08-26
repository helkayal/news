import 'package:news/domain/model/article_entity.dart';
import 'package:news/domain/repositories/news_repository.dart';

class GetArticlesUseCase {
  final NewsRepository repository;

  GetArticlesUseCase(this.repository);

  Future<List<ArticleEntity>> call(String sourceId) async {
    final response = await repository.getArticles(sourceId);
    return response ?? [];
  }
}
