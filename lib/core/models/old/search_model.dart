import 'package:hti_library/core/models/auther_model.dart';
class SearchModel {
  final List<SearchData> books;

  const SearchModel({
    required this.books,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      books:
      List.from(json['books']).map((e) => SearchData.fromJson(e)).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'books': books,
    };
  }

}

class SearchData {
  late final String id;
  late final String name;
  late final num amount;
  late final String overview;
  late final List<Author> auther;
  late final num rate;
  late final String edition;
  late final num pages;
  late final String bookImage;

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    name = json['name'] ?? '';
    amount = json['amount'] ?? 0;
    auther = List.from(json['auther']).map((e) => Author.fromJson(e)).toList();
    rate = json['rate'] ?? 0;
    edition = json['edition'] ?? '';
    pages = json['pages'] ?? 0;
    bookImage = json['bookImage'] ?? '';
  }
}
