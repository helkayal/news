import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/model/article_entity.dart';
import 'package:news/domain/usecases/get_articles_usecase.dart';

class ArticlesViewModel extends Cubit<ArticlesState> {
  final GetArticlesUseCase getArticlesUseCase;

  ArticlesViewModel(this.getArticlesUseCase) : super(ArticlesState.initial());

  Future<void> loadArticles(String sourceId) async {
    try {
      emit(
        ArticlesState(
          articles: [],
          isLoading: true,
          errorMessage: "",
          isEmpty: false,
        ),
      );

      final articles = await getArticlesUseCase.call(sourceId);

      if (articles.isEmpty) {
        emit(
          ArticlesState(
            articles: [],
            isLoading: false,
            errorMessage: "",
            isEmpty: true,
          ),
        );
      } else {
        emit(
          ArticlesState(
            articles: articles,
            isLoading: false,
            errorMessage: "",
            isEmpty: false,
          ),
        );
      }
    } catch (e) {
      emit(
        ArticlesState(
          articles: [],
          isLoading: false,
          errorMessage: e.toString(),
          isEmpty: false,
        ),
      );
    }
  }
}

class ArticlesState {
  final List<ArticleEntity> articles;
  final bool isLoading;
  final String errorMessage;
  final bool isEmpty;

  ArticlesState({
    required this.articles,
    required this.isLoading,
    required this.errorMessage,
    required this.isEmpty,
  });

  factory ArticlesState.initial() => ArticlesState(
    articles: const [],
    isLoading: false,
    errorMessage: "",
    isEmpty: false,
  );
}
