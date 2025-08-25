import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/data/model/source_response.dart';
import 'package:news/data/repositories/data_sources/local_data_source/news_local_datasource.dart';

class NewsLocalDataSourceImpl extends NewsLocalDataSource {
  @override
  Future<List<SourceResponse>?> loadSources(String categoryId) async {
    var box = await Hive.openBox<List>('news');
    var sources = box.get(categoryId);
    if (sources == null) return null;
    return sources.cast<SourceResponse>();
  }

  @override
  Future<void> saveSources(
    String category,
    List<SourceResponse> sources,
  ) async {
    var box = await Hive.openBox<List>('news');
    await box.put(category, sources);
  }
}
