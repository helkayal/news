import 'package:dio/dio.dart';
import 'package:news/data/model/articles_response.dart';
import 'package:news/data/model/source.dart';
import 'package:news/data/model/sources_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'model/article.dart';

class ApiManager {
  late Dio dio;
  static ApiManager? _apiManager;
  ApiManager._() {
    dio = Dio(BaseOptions(baseUrl: _baseUrl));
    dio.interceptors.add(PrettyDioLogger(requestHeader: true));
    dio.interceptors.add(AppInterceptor());
  }

  static ApiManager get instance {
    _apiManager ??= ApiManager._();
    return _apiManager!;
  }

  final String _baseUrl = "https://newsapi.org/v2";

  Future<List<Source>?> loadSources(String category) async {
    try {
      Response response = await dio.get(
        "/top-headlines/sources",
        queryParameters: {"category": category},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        SourcesResponse myResponse = SourcesResponse.fromJson(response.data);
        return myResponse.sources;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<Article>?> loadArticles(String sourceId) async {
    try {
      Response response = await dio.get(
        "/everything",
        queryParameters: {"sources": sourceId},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        ArticlesResponse myResponse = ArticlesResponse.fromJson(response.data);
        return myResponse.articles;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}

class AppInterceptor extends Interceptor {
  final String _apiKey = "337dc2b5fe7c467aacde1b358cbe785b";
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"X-Api-Key": _apiKey});
    super.onRequest(options, handler);
  }
}
