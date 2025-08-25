import 'package:hive_flutter/adapters.dart';
import 'package:news/data/model/source_response.dart';

class SourceAdapter extends TypeAdapter<SourceResponse> {
  @override
  SourceResponse read(BinaryReader reader) {
    var json = reader.readMap();
    return SourceResponse.fromJson(json);
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, SourceResponse obj) {
    writer.writeMap(obj.toJson());
  }
}
