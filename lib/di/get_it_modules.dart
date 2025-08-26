import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news/data/api_manager.dart';
import 'package:news/data/mappers/article_entity_mapper.dart';
import 'package:news/data/mappers/source_mapper.dart';
import 'package:news/data/model/article.dart';
import 'package:news/data/repositories/data_sources/local_data_source/news_local_datasource.dart';
import 'package:news/data/repositories/data_sources/local_data_source/news_local_datasource_impl.dart';
import 'package:news/data/repositories/data_sources/remote_datasource/news_remote_datasource.dart';
import 'package:news/data/repositories/data_sources/remote_datasource/news_remote_datasource_impl.dart';
import 'package:news/data/repositories/news_repository_impl.dart';
import 'package:news/domain/repositories/news_repository.dart';
import 'package:news/domain/usecases/get_articles_usecase.dart';
import 'package:news/domain/usecases/get_sources_usecase.dart';
import 'package:news/domain/usecases/search_articles_usecase.dart';
import 'package:news/ui/screens/news/article_view_model.dart';
import 'package:news/ui/screens/news/news_view_model.dart';
import 'package:news/ui/screens/search/search_view_model.dart';

var getIt = GetIt.instance;

void configureDependcies() {
  getIt.registerSingleton(Connectivity());
  getIt.registerSingleton(SourceMapper());
  getIt.registerSingleton(ArticleMapper());

  getIt.registerSingleton(ApiManager.instance);

  getIt.registerSingleton<NewsLocalDataSource>(
    NewsLocalDataSourceImpl(Hive.box<Article>("articles")),
  );
  getIt.registerSingleton<NewsRemoteDataSource>(
    NewsRemoteDataSourceImpl(getIt()),
  );
  getIt.registerSingleton<NewsRepository>(
    NewsRepositoryImpl(
      remoteDataSource: getIt<NewsRemoteDataSource>(),
      localDataSource: getIt<NewsLocalDataSource>(),
      connectivity: Connectivity(),
      sourceMapper: SourceMapper(),
      articleMapper: ArticleMapper(),
    ),
  );

  getIt.registerSingleton(GetSourcesByCategoryUseCase(getIt()));
  getIt.registerSingleton(GetArticlesUseCase(getIt()));
  getIt.registerSingleton(SearchArticlesUseCase(getIt()));

  getIt.registerFactory(() => NewsViewModel(getIt()));
  getIt.registerFactory(() => ArticlesViewModel(getIt()));
  getIt.registerFactory(() => SearchViewModel(getIt()));
}
