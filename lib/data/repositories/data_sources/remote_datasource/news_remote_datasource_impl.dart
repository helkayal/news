import 'package:news/data/api_manager.dart';
import 'package:news/data/repositories/data_sources/remote_datasource/news_remote_datasource.dart';

import '../../../model/source_response.dart';

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  ApiManager apiManager;
  NewsRemoteDataSourceImpl(this.apiManager);
  @override
  Future<List<SourceResponse>?> loadSources(String categoryId) {
    return apiManager.loadSources(categoryId);
  }
}
