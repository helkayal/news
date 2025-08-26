// import 'source_response.dart';

// class Article {
//   Article({
//       this.source,
//       this.author,
//       this.title,
//       this.description,
//       this.url,
//       this.urlToImage,
//       this.publishedAt,
//       this.content,});

//   Article.fromJson(dynamic json) {
//     source = json['source'] != null ? SourceResponse.fromJson(json['source']) : null;
//     author = json['author'];
//     title = json['title'];
//     description = json['description'];
//     url = json['url'];
//     urlToImage = json['urlToImage'];
//     publishedAt = json['publishedAt'];
//     content = json['content'];
//   }
//   SourceResponse? source;
//   String? author;
//   String? title;
//   String? description;
//   String? url;
//   String? urlToImage;
//   String? publishedAt;
//   String? content;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (source != null) {
//       map['source'] = source?.toJson();
//     }
//     map['author'] = author;
//     map['title'] = title;
//     map['description'] = description;
//     map['url'] = url;
//     map['urlToImage'] = urlToImage;
//     map['publishedAt'] = publishedAt;
//     map['content'] = content;
//     return map;
//   }

// }

class Article {
  Article({
    this.sourceId,
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  String? sourceId;
  String? sourceName;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article.fromJson(Map<String, dynamic> json) {
    sourceId = json['source']?['id'] ?? '';
    sourceName = json['source']?['name'] ?? '';
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    return {
      'source': {'id': sourceId, 'name': sourceName},
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
