class NewsModelLocal {
    String? author;
    String title;
    String? description;
    String url;
    String? imageUrl;
    String publishedAt;
    String? content;
    final bool isBookmark;

    NewsModelLocal({
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.imageUrl,
        required this.publishedAt,
        required this.content,
        this.isBookmark = false
    });
    NewsModelLocal copyWith({
    bool? isBookmark,
  }) {
    return NewsModelLocal(
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


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': imageUrl,
      'content': content,
      'author': author,
      'publishedAt': publishedAt,
      'isBookmark': isBookmark ? 1 : 0,
    };
  }

  factory NewsModelLocal.fromMap(Map<String, dynamic> map) {
    return NewsModelLocal(
      title: map['title'],
      description: map['description'],
      url: map['url'],
      imageUrl: map['urlToImage'],
      content: map['content'],
      author: map['author'],
      publishedAt: map['publishedAt'],
      isBookmark: map['isBookmark'] == 1,
    );
  }

}