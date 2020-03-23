import 'dart:convert';

Map<String, List<NewsModel>> newsFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<NewsModel>>(k, List<NewsModel>.from(v.map((x) => NewsModel.fromJson(x)))));

String newsToJson(Map<String, List<NewsModel>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));


class NewsModel{
    
    String author;
    String content;
    String description;
    String publishedAt;
    String title;
    String url;
    String urlToImage;

    NewsModel({
      this.author,
      this.content,
      this.description,
      this.publishedAt,
      this.title,
      this.url,
      this.urlToImage
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
      author: json["author"],
      content: json["content"],
      description: json["description"],
      publishedAt: json["publishedAt"],
      title: json["title"],
      url: json["url"],
      urlToImage: json["urlToImage"]
    );

  Map<String, dynamic> toJson() => {
      "author": author,
      "content": content,
      "description": description,
      "publishedAt": publishedAt,
      "title": title,
      "url": url,
      "urlToImage": urlToImage
  };

}