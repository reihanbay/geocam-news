import 'package:geocam_news/features/news/domain/entity/news_entity.dart';

abstract class NewsRepository {
  Future<List<NewsEntity>> getNews();
  Future<List<NewsEntity>> getNewsLocal();
  Future<List<NewsEntity>> getNewsLocalBookmarked();
  Future<NewsEntity?> getNewsLocalByTitle(String title);
  Future<void> setBookmarked(String title, bool isBookmarked);
  Future<bool> isBookmarked(String title);
}