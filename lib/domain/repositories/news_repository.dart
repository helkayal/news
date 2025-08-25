import 'package:news/domain/model/source.dart';

abstract class NewsRepository {
  Future<List<Source>?> loadSources(String categoryId);
}
