import 'package:geocam_news/features/news/domain/repositories/news_repository.dart';

import '../entity/news_entity.dart';

class LocalNewsUsecase {
  final NewsRepository repo;

  LocalNewsUsecase(this.repo);

  Future<List<NewsEntity>> getNewsLocal() => repo.getNewsLocal();
  
  Future<NewsEntity?> getNewsLocalByTitle(String title) => repo.getNewsLocalByTitle(title);
  
  Future<void> setBookmarked(String title, bool isBookmarked) => repo.setBookmarked(title, isBookmarked);
  Future<bool> isBookmarked(String title) => repo.isBookmarked(title);
  
  Future<List<NewsEntity>> getNewsLocalBookmarked()=> repo.getNewsLocalBookmarked();
}