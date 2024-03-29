import 'package:hti_library/core/models/auther_model.dart';
import 'package:hti_library/core/models/top_borrow_model.dart';

class BookDetailsModel {
  final BookDetails book;
  final List<SimpleBook> sameCategory;
  final List<SimpleBook> sameAuthor;
  final List<SimpleBook> sameEdition;

  const BookDetailsModel({
    required this.book,
    required this.sameCategory,
    required this.sameAuthor,
    required this.sameEdition,
  });

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      book: BookDetails.fromJson(json['book']),
      sameCategory: List.from(json['same_category'])
          .map((e) => SimpleBook.fromJson(e))
          .toList(),
      sameAuthor: List.from(json['same_auther'])
          .map((e) => SimpleBook.fromJson(e))
          .toList(),
      sameEdition: List.from(json['same_edition'])
          .map((e) => SimpleBook.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book': book,
      'same_category': sameCategory,
      'same_auther': sameAuthor,
      'same_edition': sameEdition,
    };
  }
}

class BookDetails {
  late final String id;
  late final String name;
  late final num amount;
  late final String overview;
  late final List<Author> authors;
  late final num rate;
  late final String edition;
  late final num pages;
  late final String category;
  late final String library;
  late final String type;
  late final num topBorrow;
  late final String bookImage;
  late final String bookLink;
  late final String createdAt;
  late final String updatedAt;
  late final num __v;

  BookDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    name = json['name'] ?? '';
    amount = json['amount'] ?? 0;
    overview = json['overview'] ?? '';
    authors = List.from(json['auther']).map((e) => Author.fromJson(e)).toList();
    rate = json['rate'] ?? 0;
    edition = json['edition'] ?? '';
    pages = json['pages'] ?? 0;
    category = json['category'] ?? '';
    topBorrow = json['top_Borrow'] ?? 0;
    library = json['library'] ?? 0;
    type = json['type'] ?? 0;
    bookImage = json['bookImage'] ?? '';
    bookLink = json['bookLink'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    __v = json['__v'] ?? 0;
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
    _data['library'] = library;
    _data['type'] = type;
    _data['top_Borrow'] = topBorrow;
    _data['bookImage'] = bookImage;
    _data['bookLink'] = bookLink;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = __v;
    return _data;
  }
}
