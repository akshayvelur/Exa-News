
  
class Article {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String ?url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author']??'',
      title: json['title']??'',
      description: json['description']??'',
      url: json['url']??'',
      urlToImage: json['urlToImage']??'',
      publishedAt: DateTime.parse(json['publishedAt']!=null?json['publishedAt']:null),
      content: json['content']??'',
    );
  }
}

// source


class Source {
  final String? id;
  final String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}
