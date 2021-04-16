class Articles {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;
  final String articleUrl;
  final String author;

  Articles({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.articleUrl,
    this.author,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      articleUrl: json['url'],
    );
  }
}

