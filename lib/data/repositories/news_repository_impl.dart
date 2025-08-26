import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/data/mappers/article_entity_mapper.dart';
import 'package:news/data/mappers/source_mapper.dart';
import 'package:news/data/repositories/data_sources/local_data_source/news_local_datasource.dart';
import 'package:news/data/repositories/data_sources/remote_datasource/news_remote_datasource.dart';
import 'package:news/domain/model/article_entity.dart';
import 'package:news/domain/model/source.dart';
import 'package:news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final Connectivity connectivity;
  final SourceMapper sourceMapper;
  final ArticleMapper articleMapper;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
    required this.sourceMapper,
    required this.articleMapper,
  });

  @override
  Future<List<Source>?> loadSources(String categoryId) async {
    var result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      var sources = await remoteDataSource.loadSources(categoryId);
      localDataSource.saveSources(categoryId, sources ?? []);
      return sourceMapper.fromDataModels(sources ?? []);
    } else {
      var sources = await localDataSource.loadSources(categoryId);
      return sourceMapper.fromDataModels(sources ?? []);
    }
  }

  @override
  Future<List<ArticleEntity>?> getArticles(String sourceId) async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      final remoteArticles =
          await remoteDataSource.loadArticles(sourceId) ?? [];

      for (var article in remoteArticles) {
        article.sourceId = sourceId;
      }
      await localDataSource.saveArticles(sourceId, remoteArticles);

      return articleMapper.fromDataModels(remoteArticles);
    } else {
      final cachedArticles = await localDataSource.loadArticles(sourceId) ?? [];

      return articleMapper.fromDataModels(cachedArticles);
    }
  }

  @override
  Future<List<ArticleEntity>> searchArticles(
    String query, {
    String? sourceId,
  }) async {
    try {
      final remoteArticles = await remoteDataSource.searchArticles(query);
      for (var article in remoteArticles) {
        article.sourceId ??= article.sourceId ?? "unknown";
      }
      await localDataSource.cacheArticles(remoteArticles);
      return articleMapper.fromDataModels(remoteArticles);
    } catch (_) {
      final cached = await localDataSource.searchArticles(
        query,
        sourceId: sourceId,
      );
      return articleMapper.fromDataModels(cached);
    }
  }
}
