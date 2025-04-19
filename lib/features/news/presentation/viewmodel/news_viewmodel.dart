import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/domain/usecase/news_usecase.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsUsecase newsUsecase;

  NewsViewModel(this.newsUsecase);

  bool isLoadingState = false;
  List<NewsEntity> listNews = [];
  String message = "";

  Future<void> getNews() async {
    isLoadingState = true;
    try {
      log("Disini1");
      final result = await newsUsecase.getNews();
      if (result.isNotEmpty) {
        listNews.addAll(result);
        isLoadingState = false;
        log("Disini tes ${listNews[0].publishedAt}");
        notifyListeners();
      }
    } catch (e) {
      isLoadingState = false;
      message = e.toString();
      notifyListeners();
    }
  }
}
