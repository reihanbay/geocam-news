import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/domain/usecase/local_news_usecase.dart';
import 'package:geocam_news/features/news/domain/usecase/news_usecase.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsUsecase newsUsecase;
  final LocalNewsUsecase localNewsUsecase;

  NewsViewModel(this.newsUsecase, this.localNewsUsecase);

  bool isLoadingState = false;
  List<NewsEntity> listNews = [];
  List<NewsEntity> listNewsLocal = [];
  String message = "";

  Future<void> getNews() async {
    isLoadingState = true;
    try {
      final result = await newsUsecase.getNews();
      if (result.isNotEmpty) {
        listNews.clear();
        listNews.addAll(result);
        isLoadingState = false;
        notifyListeners();
      }
    } catch (e) {
      isLoadingState = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<void> getNewsBookmarked() async {
    isLoadingState = true;
    try {
      final result = await localNewsUsecase.getNewsLocalBookmarked();
      log(result.toString());
      if (result.isNotEmpty) {
        listNewsLocal.clear();
        listNewsLocal.addAll(result);
        isLoadingState = false;
        notifyListeners();
      }
    } catch (e) {
      isLoadingState = false;
      message = e.toString();
      notifyListeners();
    }
  }

  
}
