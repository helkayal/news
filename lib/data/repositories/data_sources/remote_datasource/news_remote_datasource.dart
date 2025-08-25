import '../../../model/source_response.dart';

abstract class NewsRemoteDataSource {
  Future<List<SourceResponse>?> loadSources(String categoryId);
}
