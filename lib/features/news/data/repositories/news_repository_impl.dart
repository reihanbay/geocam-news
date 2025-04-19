

import 'dart:developer';

import 'package:geocam_news/features/news/data/datasources/news_api_services.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository{
  final NewsApiServices remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<List<NewsEntity>> getNews() async {
    try {
      final response = await remoteDataSource.getNews();
      List<NewsEntity> parseModel = [];
      for (var data in response) { 
          log("Disini2 ss${data}");
          parseModel.add(NewsEntity(source: data.source, author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content));
      }
      // log("Disini2 ${parseModel}");
      return parseModel;
    } catch (e) {
      throw Exception(e);
    }
  }

}