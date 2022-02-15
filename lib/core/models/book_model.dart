import 'auther_model.dart';

class Book {
  late final String id;
  late final String name;
  late final int amount;
  late final String overview;
  late final List<Author> authors;

  late final int rate;
  late final String edition;
  late final int pages;
  late final String category;
  late final int topBorrow;
  late final String bookImage;
  late final String bookLink;
  late final String createdAt;
  late final String updatedAt;
  late final int __v;
  late final String bookImagePath;
  late final String bookLinkPath;

  Book.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    name = json['name'] ?? '';
    amount = json['amount'] ?? 0;
    overview = json['overview'] ?? '';

    authors =
        List.from(json['authers']).map((e) => Author.fromJson(e)).toList();

    rate = json['rate'] ?? 0;
    edition = json['edition'] ?? '';
    pages = json['pages'] ?? 0;
    category = json['category'] ?? '';
    topBorrow = json['top_Borrow'] ?? 0;
    bookImage = json['bookImage'] ?? '';
    bookLink = json['bookLink'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    __v = json['__v'] ?? 0;
    bookImagePath = json['bookImagepath'] ?? '';
    bookLinkPath = json['bookLinkpath'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['amount'] = amount;
    _data['overview'] = overview;

    _data['rate'] = rate;
    _data['edition'] = edition;
    _data['pages'] = pages;
    _data['category'] = category;
    _data['top_Borrow'] = topBorrow;
    _data['bookImage'] = bookImage;
    _data['bookLink'] = bookLink;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = __v;
    _data['bookImagepath'] = bookImagePath;
    _data['bookLinkpath'] = bookLinkPath;
    return _data;
  }
}
