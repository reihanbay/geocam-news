import 'dart:developer';

import 'package:geocam_news/features/news/data/datasources/news_local_datasources.dart';
import 'package:geocam_news/features/news/data/datasources/news_remote_datasources.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository{
  final NewsRemoteDatasources remoteDataSource;
  final NewsLocalDatasources localDatasources;

  NewsRepositoryImpl(this.remoteDataSource, this.localDatasources);
  
  @override
  Future<List<NewsEntity>> getNews() async {
    try {
      final response = await remoteDataSource.getNews();
      localDatasources.insertNews(response);
      List<NewsEntity> parseModel = [];
      for (var data in response) { 
          parseModel.add(NewsEntity(author: data.author, title: data.title, description: data.description, url: data.url, imageUrl: data.imageUrl, publishedAt: data.publishedAt, content: data.content));
      }
      return parseModel;
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<List<NewsEntity>> getNewsLocal() async {
    final local = await localDatasources.getNews();
    return local.map((data) => NewsEntity(author: data.author, title: data.title, description: data.description, url: data.url, imageUrl: data.imageUrl, publishedAt: data.publishedAt, content: data.content, isBookmark: data.isBookmark)).toList();
  }
  
  @override
  Future<void> setBookmarked(String title, bool isBookmarked) async {
    await localDatasources.updateBookmark(title, isBookmarked);
  }
  
  @override
  Future<NewsEntity?> getNewsLocalByTitle(String title) async {
    final data = await localDatasources.getNewsByTitle(title);
    return data != null ? NewsEntity(author: data.author, title: data.title, description: data.description, url: data.url, imageUrl: data.imageUrl, publishedAt: data.publishedAt, content: data.content, isBookmark: data.isBookmark) : null;
  }
  
  @override
  Future<List<NewsEntity>> getNewsLocalBookmarked() async {
     final local = await localDatasources.getNewsBookmarked();
    return local.map((data) => NewsEntity(author: data.author, title: data.title, description: data.description, url: data.url, imageUrl: data.imageUrl, publishedAt: data.publishedAt, content: data.content, isBookmark: data.isBookmark)).toList();
  }
  
  @override
  Future<bool> isBookmarked(String title) async {
    final isBookmark = await localDatasources.isBookmarked(title);
    return isBookmark == 1 ? true : false;
  }
}