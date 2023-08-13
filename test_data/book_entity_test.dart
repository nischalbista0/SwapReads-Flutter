import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:swapreads/features/home/domain/entity/book_entity.dart';

Future<List<BookEntity>> getAllBooks() async {
  final response = await rootBundle.loadString('test_data/book_test_data.json');
  final jsonList = await json.decode(response);

  final List<BookEntity> movieList = jsonList
      .map<BookEntity>(
        (json) => BookEntity.fromJson(json),
      )
      .toList();

  print(movieList);
  return Future.value(movieList);
}

Future<List<BookEntity>> getBookmarkedBooks() async {
  final response =
      await rootBundle.loadString('test_data/bookmarked_books_data.json');
  final jsonList = await json.decode(response);

  final List<BookEntity> bookmarked = jsonList
      .map<BookEntity>(
        (json) => BookEntity.fromJson(json),
      )
      .toList();

  return Future.value(bookmarked);
}

Future<List<BookEntity>> getUserBooks() async {
  final response =
      await rootBundle.loadString('test_data/user_books_test.json');
  final jsonList = await json.decode(response);

  final List<BookEntity> userBooks = jsonList
      .map<BookEntity>(
        (json) => BookEntity.fromJson(json),
      )
      .toList();

  return Future.value(userBooks);
}
