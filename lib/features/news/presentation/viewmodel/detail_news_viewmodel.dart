import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/domain/usecase/local_news_usecase.dart';

class DetailNewsViewmodel extends ChangeNotifier {
  final LocalNewsUsecase newsUsecase;

  DetailNewsViewmodel(this.newsUsecase);

  bool isLoadingState = false;
  bool isBookmark = false;
  NewsEntity? news;
  String message = "";

  // Future<void> getNews() async {
  //   isLoadingState = true;
  //   try {
  //     final result = await newsUsecase.getNews();
  //     if (result.isNotEmpty) {
  //       listNews.addAll(result);

  //     }
  //   } catch (e) {
  //     isLoadingState = false;
  //     message = e.toString();
  //     notifyListeners();
  //   }
  // }

  Future<void> isBookmarked(String title) async {
    final state = await newsUsecase.isBookmarked(title);
    log("Pengin tau state $state");
    isBookmark = state;
    notifyListeners();
  }

  Future<void> getNewsByTitle(String title) async {
    isLoadingState = true;
    try {
      final result = await newsUsecase.getNewsLocalByTitle(title);
      isLoadingState = false;
      news = result;
      notifyListeners();
    } catch (e) {
      isLoadingState = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateBookmark(String title, bool isBookmarked) async {
    try {
      await newsUsecase.setBookmarked(title, isBookmarked);
    } catch (e) {
      message = e.toString();
      notifyListeners();
    }
  }
}
