import 'package:geocam_news/core/services/api_client_services.dart';
import 'package:geocam_news/features/news/data/models/news_model_response.dart';

class NewsRemoteDatasources {
  final ApiClient client;

  NewsRemoteDatasources(this.client);

  Future<List<NewsModelResponse>> getNews() async {
    try {
      final response = await client.dio
          .get('https://newsapi.org/v2/top-headlines', queryParameters: {
        'country': 'us',
        'apiKey': '6ca07e9973d64ca88cf3a1aacc65427e',
      });
      final List news = response.data['articles'];
      return news.map((e) => NewsModelResponse.fromJson(e)).toList();
    } catch (e) {
      throw Exception('GET error: $e');
    }
  }
}
