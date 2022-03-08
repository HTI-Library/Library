import 'package:hti_library/core/models/auther_model.dart';

class GetSavedBooksModel {
  final List<BookSavedData>? books;
  final num allBooks;

  const GetSavedBooksModel({
    required this.books,
    required this.allBooks,
  });

  factory GetSavedBooksModel.fromJson(Map<String, dynamic> json) {
    return GetSavedBooksModel(
      books:
      List.from(json['books']).map((e) => BookSavedData.fromJson(e)).toList(),
      allBooks: json['allBooks'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'books': books,
      'allBooks': allBooks,
    };
  }
}

class BookSavedData {
  late final String id;
  late final String name;
  late final num amount;
  late final String overview;
  late final num rate;
  late final String edition;
  late final num pages;
  late final String category;
  late final String library;
  late final String type;
  late final String bookNum;
  late final List<Author> author;
  late final String classificationNum;
  late final num topBorrow;
  late final String bookImage;
  late final String bookLink;
  late final String createdAt;
  late final String updatedAt;
  late final num __v;

  BookSavedData.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    name = json['name'] ?? '';
    amount = json['amount'] ?? 0;
    overview = json['overview'] ?? '';
    author = List.from(json['auther']).map((e) => Author.fromJson(e)).toList();
    rate = json['rate'] ?? 0;
    edition = json['edition'] ?? '';
    pages = json['pages'] ?? 0;
    category = json['category'] ?? '';
    library = json['library'] ?? '';
    type = json['type'] ?? '';
    bookNum = json['bookNum'] ?? '';
    classificationNum = json['classificationNum'] ?? '';
    topBorrow = json['top_Borrow'] ?? 0;
    bookImage = json['bookImage'] ?? '';
    bookLink = json['bookLink'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    __v = json['__v'] ?? 0;

  }
}
