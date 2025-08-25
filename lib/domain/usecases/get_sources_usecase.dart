import 'package:news/domain/model/source.dart';
import 'package:news/domain/repositories/news_repository.dart';

class GetSourcesByCategoryUseCase {
  NewsRepository newsRepository;

  GetSourcesByCategoryUseCase(this.newsRepository);

  Future<List<Source>?> execute(String category) =>
      newsRepository.loadSources(category);
}
