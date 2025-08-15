import 'package:flutter/material.dart';
import 'package:news/data/model/source.dart';
import 'package:news/data/repositories/news_repository.dart';

class NewsViewModel extends ChangeNotifier {
  NewsRepository newsRepository;
  NewsViewModel(this.newsRepository);

  List<Source> sources = [];
  var isLoading = false;
  var errorMessage = "";

  loadSources(String categoryId) async {
    try {
      isLoading = true;
      notifyListeners();
      sources = (await newsRepository.loadSources(categoryId))!;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
