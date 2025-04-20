

import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/domain/repositories/news_repository.dart';

class NewsUsecase{
  final NewsRepository repo;

  NewsUsecase(this.repo);

  Future<List<NewsEntity>> getNews() => repo.getNews();
 
}