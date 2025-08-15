import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/data/model/source.dart';
import 'package:news/data/repositories/data_sources/news_local_datasource.dart';
import 'package:news/data/repositories/data_sources/news_remote_datasource.dart';

class NewsRepository {
  NewsRemoteDataSource remoteDataSource;
  NewsLocalDataSource localDataSource;
  Connectivity connectivity;
  NewsRepository(
    this.remoteDataSource,
    this.localDataSource,
    this.connectivity,
  );

  Future<List<Source>?> loadSources(String categoryId) async {
    var result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      var sources = await remoteDataSource.loadSources(categoryId);
      localDataSource.saveSources(categoryId, sources ?? []);
      return sources;
    } else {
      return localDataSource.loadSources(categoryId);
    }
  }
}
