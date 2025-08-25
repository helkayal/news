import 'package:news/data/model/source_response.dart';
import 'package:news/domain/model/source.dart';

class SourceMapper {
  Source fromDataModel(SourceResponse source) {
    return Source(id: source.id ?? "", name: source.name ?? "");
  }

  List<Source> fromDataModels(List<SourceResponse> sources) {
    return sources.map(fromDataModel).toList();
  }
}
