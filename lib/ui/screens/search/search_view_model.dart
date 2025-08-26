import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/model/article_entity.dart';
import 'package:news/domain/usecases/search_articles_usecase.dart';

class SearchViewModel extends Cubit<SearchState> {
  final SearchArticlesUseCase searchUseCase;

  SearchViewModel(this.searchUseCase) : super(SearchState.initial());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchState.initial());
      return;
    }

    try {
      emit(
        SearchState(
          articles: [],
          isLoading: true,
          errorMessage: "",
          isEmpty: false,
        ),
      );
      final articles = await searchUseCase.execute(query);
      if (articles.isEmpty) {
        emit(
          SearchState(
            articles: [],
            isLoading: false,
            errorMessage: "",
            isEmpty: true,
          ),
        );
      } else {
        emit(
          SearchState(
            articles: articles,
            isLoading: false,
            errorMessage: "",
            isEmpty: false,
          ),
        );
      }
    } catch (e) {
      emit(
        SearchState(
          articles: [],
          isLoading: false,
          errorMessage: e.toString(),
          isEmpty: false,
        ),
      );
    }
  }
}

class SearchState {
  final List<ArticleEntity> articles;
  final bool isLoading;
  final String errorMessage;
  bool isEmpty;

  SearchState({
    required this.articles,
    required this.isLoading,
    required this.errorMessage,
    required this.isEmpty,
  });

  factory SearchState.initial() => SearchState(
    articles: const [],
    isLoading: false,
    errorMessage: "",
    isEmpty: false,
  );
}
