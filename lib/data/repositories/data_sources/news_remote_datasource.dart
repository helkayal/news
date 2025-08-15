import 'package:news/data/api_manager.dart';

import '../../model/source.dart';

class NewsRemoteDataSource {
  ApiManager apiManager;
  NewsRemoteDataSource(this.apiManager);
  Future<List<Source>?> loadSources(String categoryId) {
    return apiManager.loadSources(categoryId);
  }
}
