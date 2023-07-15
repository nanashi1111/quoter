import 'dart:convert';

List<QuoteEntity> quoteEntityFromJson(String str) => List<QuoteEntity>.from(json.decode(str).map((x) => QuoteEntity.fromJson(x)));

String quoteEntityToJson(List<QuoteEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuoteEntity {
  String id;
  String content;
  String author;
  List<String> tags;
  String authorSlug;
  int length;

  QuoteEntity({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
    required this.authorSlug,
    required this.length,
  });

  factory QuoteEntity.fromJson(Map<String, dynamic> json) => QuoteEntity(
    id: json["_id"],
    content: json["content"],
    author: json["author"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    authorSlug: json["authorSlug"],
    length: json["length"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
    "author": author,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "authorSlug": authorSlug,
    "length": length,
  };
}
