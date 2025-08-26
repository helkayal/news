// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:news/data/model/article.dart';
// import 'package:news/data/model/source_response.dart';
// import 'package:news/data/repositories/data_sources/local_data_source/news_local_datasource.dart';

// class NewsLocalDataSourceImpl extends NewsLocalDataSource {
//   final Box<Article> articleBox;

//   NewsLocalDataSourceImpl(this.articleBox);

//   @override
//   Future<List<SourceResponse>?> loadSources(String categoryId) async {
//     var box = await Hive.openBox<List>('news');
//     var sources = box.get(categoryId);
//     if (sources == null) return null;
//     return sources.cast<SourceResponse>();
//   }

//   @override
//   Future<void> saveSources(
//     String category,
//     List<SourceResponse> sources,
//   ) async {
//     var box = await Hive.openBox<List>('news');
//     await box.put(category, sources);
//   }

//   @override
//   Future<List<Article>?> loadArticles(String sourceId) async {
//     final results = articleBox.values
//         .where((a) => a.source?.id == sourceId)
//         .toList();

//     return results.isEmpty ? null : results;
//   }

//   @override
//   Future<void> saveArticles(String sourceId, List<Article> articles) async {
//     final keysToDelete = articleBox.keys.where((key) {
//       final article = articleBox.get(key);
//       return article?.source?.id == sourceId;
//     }).toList();
//     await articleBox.deleteAll(keysToDelete);

//     for (var article in articles) {
//       if (article.source == null) {
//         article.source = SourceResponse(id: sourceId, name: "");
//       } else {
//         article.source = SourceResponse(
//           id: sourceId,
//           name: article.source?.name ?? "",
//         );
//       }
//       await articleBox.add(article);
//     }
//   }

//   @override
//   Future<void> cacheArticles(List<Article> articles) async {
//     await articleBox.clear();
//     await articleBox.addAll(articles);
//   }

//   @override
//   Future<List<Article>> searchArticles(String query) async {
//     return articleBox.values
//         .where(
//           (a) => a.title?.toLowerCase().contains(query.toLowerCase()) ?? false,
//         )
//         .toList();
//   }
// }
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/data/model/article.dart';
import 'package:news/data/model/source_response.dart';
import 'package:news/data/repositories/data_sources/local_data_source/news_local_datasource.dart';

class NewsLocalDataSourceImpl extends NewsLocalDataSource {
  final Box<Article> articleBox;

  NewsLocalDataSourceImpl(this.articleBox);

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

  @override
  Future<List<Article>?> loadArticles(String sourceId) async {
    final results = articleBox.values
        .where((a) => a.sourceId == sourceId)
        .toList();
    return results.isEmpty ? null : results;
  }

  @override
  Future<void> saveArticles(String sourceId, List<Article> articles) async {
    final keysToDelete = articleBox.keys.where((key) {
      final article = articleBox.get(key);
      return article?.sourceId == sourceId;
    }).toList();
    await articleBox.deleteAll(keysToDelete);

    for (var article in articles) {
      article.sourceId = sourceId;
      await articleBox.add(article);
    }
  }

  // @override
  // Future<void> cacheArticles(List<Article> articles) async {
  //   await articleBox.clear();
  //   for (var article in articles) {
  //     article.sourceId ??= "unknown";
  //     await articleBox.add(article);
  //   }
  // }

  @override
  Future<void> cacheArticles(List<Article> articles) async {
    for (var article in articles) {
      article.sourceId = article.sourceId?.isNotEmpty == true
          ? article.sourceId
          : "unknown";

      final existingKey = articleBox.keys.firstWhere((key) {
        final a = articleBox.get(key);
        return a != null &&
            a.url == article.url &&
            a.sourceId == article.sourceId;
      }, orElse: () => null);

      if (existingKey != null) {
        await articleBox.put(existingKey, article);
      } else {
        await articleBox.add(article);
      }
    }
  }

  @override
  Future<List<Article>> searchArticles(String query, {String? sourceId}) async {
    final lowerQuery = query.toLowerCase();
    return articleBox.values
        .where(
          (a) =>
              (a.title?.toLowerCase().contains(lowerQuery) ?? false) ||
              (a.description?.toLowerCase().contains(lowerQuery) ?? false),
        )
        .toList();
  }
}
