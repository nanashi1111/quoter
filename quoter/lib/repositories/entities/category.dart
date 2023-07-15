import 'dart:convert';

List<QuoteCategoryEntity> quoteCategoryEntityFromJson(String str) => List<QuoteCategoryEntity>.from(json.decode(str).map((x) => QuoteCategoryEntity.fromJson(x)));

String quoteCategoryEntityToJson(List<QuoteCategoryEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuoteCategoryEntity {
  String id;
  String name;
  String? slug;
  int quoteCount;

  QuoteCategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.quoteCount,
  });

  factory QuoteCategoryEntity.fromJson(Map<String, dynamic> json) => QuoteCategoryEntity(
    id: json["_id"],
    name: json["name"],
    slug: json["slug"],
    quoteCount: json["quoteCount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "slug": slug,
    "quoteCount": quoteCount,
  };
}