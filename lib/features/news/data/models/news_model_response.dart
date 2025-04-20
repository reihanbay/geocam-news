class NewsModelResponse {
    Source source;
    String? author;
    String title;
    String? description;
    String url;
    String? imageUrl;
    String publishedAt;
    String? content;

    NewsModelResponse({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.imageUrl,
        required this.publishedAt,
        required this.content,
    });

    factory NewsModelResponse.fromJson(Map<String, dynamic> json) => NewsModelResponse(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        imageUrl: json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"],
    );
}

class Source {
    String? id;
    String? name;

    Source({
        required this.id,
        required this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}