
class NewsEntity {
    String? author;
    String title;
    String? description;
    String url;
    String? imageUrl;
    String publishedAt;
    String? content;
    final bool isBookmark;

    NewsEntity({
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.imageUrl,
        required this.publishedAt,
        required this.content,
        this.isBookmark = false
    });
    NewsEntity copyWith({
    bool? isBookmark,
  }) {
    return NewsEntity(
      author: author,
      title: title,
      description: description,
      url: url,
      imageUrl: imageUrl,
      content: content,
      publishedAt: publishedAt,
      isBookmark: isBookmark ?? this.isBookmark,
    );
  }

}
