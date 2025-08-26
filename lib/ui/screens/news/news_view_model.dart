import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/model/source.dart';
import 'package:news/domain/usecases/get_sources_usecase.dart';

class NewsViewModel extends Cubit<NewsState> {
  GetSourcesByCategoryUseCase getSourcesUseCase;
  NewsViewModel(this.getSourcesUseCase) : super(NewsState.initial());

  Future<void> loadSources(String categoryId) async {
    try {
      emit(
        NewsState(
          sources: [],
          isLoading: true,
          errorMessage: "",
          isEmpty: false,
        ),
      );

      final sources = await getSourcesUseCase.execute(categoryId) ?? [];

      if (sources.isEmpty) {
        emit(
          NewsState(
            sources: [],
            isLoading: false,
            errorMessage: "",
            isEmpty: true,
          ),
        );
      } else {
        emit(
          NewsState(
            sources: sources,
            isLoading: false,
            errorMessage: "",
            isEmpty: false,
          ),
        );
      }
    } catch (e) {
      emit(
        NewsState(
          sources: [],
          isLoading: false,
          errorMessage: e.toString(),
          isEmpty: false,
        ),
      );
    }
  }
}

class NewsState {
  List<Source> sources = [];
  var isLoading = false;
  var errorMessage = "";
  bool isEmpty;

  NewsState({
    required this.sources,
    required this.isLoading,
    required this.errorMessage,
    required this.isEmpty,
  });

  NewsState.initial({
    this.sources = const [],
    this.isLoading = false,
    this.errorMessage = "",
    this.isEmpty = false,
  });
}
