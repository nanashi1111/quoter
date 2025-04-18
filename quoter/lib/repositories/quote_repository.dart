import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:quoter/models/quote_editor.dart';
import 'package:quoter/repositories/apis.dart';
import 'package:quoter/repositories/base_repository.dart';
import 'package:quoter/repositories/cached/quote_data.dart';
import 'package:quoter/repositories/entities/category_entity.dart';
import 'package:quoter/repositories/entities/quote_editor_entity.dart';
import 'package:quoter/repositories/entities/quote_entity.dart';
import 'dart:convert';

class QuoteRepository extends BaseRepository {
  Future<List<CategoryEntity>> getCatgories() async {

    List<CategoryEntity> categories = [
      const CategoryEntity(name: "Love", slug: "Love"),
      const CategoryEntity(name: "Friendship", slug: "Friendship"),
      const CategoryEntity(name: "Motivation", slug: "Motivation"),
      const CategoryEntity(name: "Family", slug: "Family"),
      const CategoryEntity(name: "Life", slug: "Life"),
      const CategoryEntity(name: "Happiness", slug: "Happiness"),
      const CategoryEntity(name: "Women", slug: "Women"),
      const CategoryEntity(name: "Mother", slug: "Mother"),
      const CategoryEntity(name: "Sad", slug: "Sad"),
      const CategoryEntity(name: "Father", slug: "Father"),
      const CategoryEntity(name: "Positive", slug: "Positive"),
      const CategoryEntity(name: "Alone", slug: "Alone"),
      const CategoryEntity(name: "Trust", slug: "Trust"),
      const CategoryEntity(name: "Funny", slug: "Funny"),
    ];
    return categories;
  }

  Future<List<QuoteEntity>> searchQuotes(String query) async {
    return QuoteData.getAllQuotes(query).map((quote) => QuoteEntity(content: quote)).toList();
  }

  Future<List<QuoteEntity>> getQuotes(String categorySlug) async {

    List<QuoteEntity> quotes = QuoteData.getQuotesOfCategory(categorySlug).map((quoteContent) {
      return QuoteEntity(content: quoteContent);
    }).toList();
    return quotes;
  }

  Future saveQuote(QuoteEditor quoteEditor) async {
    await dataBaseManager.saveQuote(quoteEditor.toEntity());
    int numberOfQuotes = (await dataBaseManager.getQuotes()).length;
    debugPrint("numberOfQuotes = $numberOfQuotes");
  }

  Future<List<QuoteEditor>> getMyQuotes() async {
    return (await dataBaseManager.getQuotes()).map((e) => e.toModel()).toList();
  }
}
