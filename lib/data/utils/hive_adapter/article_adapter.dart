// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:news/data/model/article.dart';

// class ArticleAdapter extends TypeAdapter<Article> {
//   @override
//   final int typeId = 2;

//   @override
//   Article read(BinaryReader reader) {
//     var json = reader.readMap();
//     return Article.fromJson(Map<String, dynamic>.from(json));
//   }

//   @override
//   void write(BinaryWriter writer, Article obj) {
//     writer.writeMap(obj.toJson());
//   }
// }
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/article.dart';

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  final int typeId = 2;

  @override
  Article read(BinaryReader reader) {
    final json = reader.readMap();
    return Article.fromJson(Map<String, dynamic>.from(json));
  }

  @override
  void write(BinaryWriter writer, Article obj) {
    writer.writeMap(obj.toJson());
  }
}
