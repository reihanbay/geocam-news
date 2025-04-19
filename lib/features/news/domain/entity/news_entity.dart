import '../../data/models/news_model_response.dart';

class NewsEntity {
    Source source;
    String? author;
    String title;
    String? description;
    String url;
    String? urlToImage;
    String publishedAt;
    String? content;
    final bool isBookmark;

    NewsEntity({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
        this.isBookmark = false
    });
    NewsEntity copyWith({
    bool? isBookmark,
  }) {
    return NewsEntity(
      source: source,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      content: content,
      publishedAt: publishedAt,
      isBookmark: isBookmark ?? this.isBookmark,
    );
  }

}
