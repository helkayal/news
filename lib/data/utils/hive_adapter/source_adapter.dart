import 'package:hive_flutter/adapters.dart';
import 'package:news/data/model/source.dart';

class SourceAdapter extends TypeAdapter<Source> {
  @override
  Source read(BinaryReader reader) {
    var json = reader.readMap();
    return Source.fromJson(json);
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Source obj) {
    writer.writeMap(obj.toJson());
  }
}
