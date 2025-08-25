import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/model/source.dart';
import 'package:news/domain/usecases/get_sources_usecase.dart';

class NewsViewModel extends Cubit<NewsState> {
  GetSourcesByCategoryUseCase getSourcesUseCase;
  NewsViewModel(this.getSourcesUseCase) : super(NewsState.initial());

  loadSources(String categoryId) async {
    try {
      emit(NewsState(sources: [], isLoading: true, errorMessage: ""));
      var sources = (await getSourcesUseCase.execute(categoryId))!;
      emit(NewsState(sources: sources, isLoading: false, errorMessage: ""));
    } catch (e) {
      emit(
        NewsState(sources: [], isLoading: false, errorMessage: e.toString()),
      );
    }
  }
}

class NewsState {
  List<Source> sources = [];
  var isLoading = false;
  var errorMessage = "";

  NewsState({
    required this.sources,
    required this.isLoading,
    required this.errorMessage,
  });

  NewsState.initial({
    this.sources = const [],
    this.isLoading = false,
    this.errorMessage = "",
  });
}
