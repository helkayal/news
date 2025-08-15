import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/data/model/source.dart';

class NewsLocalDataSource {
  Future<List<Source>?> loadSources(String categoryId) async {
    var box = await Hive.openBox('news');
    var sources = box.get(categoryId);
    return sources;
  }

  Future<void> saveSources(String category, List<Source> sources) async {
    var box = await Hive.openBox('news');
    box.put(category, sources);
  }
}
