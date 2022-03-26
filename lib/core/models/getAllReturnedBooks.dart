
class GetAllReturnedBooks{
  final List<BooksReturned> books;
  final int allBooks;

const GetAllReturnedBooks({
required this.books,
required this.allBooks,
});


  factory GetAllReturnedBooks.fromJson(Map<String, dynamic> json){
    return GetAllReturnedBooks (
      allBooks:json['allBooks'],
      books: List.from(json['books']).map((e) => BooksReturned.fromJson(e)).toList(),
    );


}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['books'] = books.map((e)=>e.toJson()).toList();
_data['allBooks'] = allBooks;
return _data;
}
}

class BooksReturned {
  BooksReturned({
    required this.book,
    required this.userEmail,
    required this.userName,
    required this.returnID,
    required this.userImage,
    required this.borrowStartTime,
    required this.borrowEndTime,
    required this.returnAt,
  });
  late final Book book;
  late final String userEmail;
  late final String userName;
  late final String returnID;
  late final String userImage;
  late final String borrowStartTime;
  late final String borrowEndTime;
  late final String returnAt;

  BooksReturned.fromJson(Map<String, dynamic> json){
    book = Book.fromJson(json['book']);
    userEmail = json['userEmail'];
    userName = json['userName'];
    returnID = json['returnID'];
    userImage = json['userImage'];
    borrowStartTime = json['borrowStartTime'];
    borrowEndTime = json['borrowEndTime'];
    returnAt = json['returnAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['book'] = book.toJson();
    _data['userEmail'] = userEmail;
    _data['userName'] = userName;
    _data['returnID'] = returnID;
    _data['userImage'] = userImage;
    _data['borrowStartTime'] = borrowStartTime;
    _data['borrowEndTime'] = borrowEndTime;
    _data['returnAt'] = returnAt;
    return _data;
  }
}

class Book {
  Book({
    required this.id,
    required this.name,
    required this.amount,
    required this.overview,
    required this.auther,
    required this.rate,
    required this.edition,
    required this.pages,
    required this.category,
    required this.library,
    required this.type,
    required this.bookNum,
    required this.classificationNum,
    required this.topBorrow,
    required this.bookImage,
    required this.bookLink,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
  late final String id;
  late final String name;
  late final num amount;
  late final String overview;
  late final List<Auther> auther;
  late final double rate;
  late final String edition;
  late final num pages;
  late final String category;
  late final String library;
  late final String type;
  late final String bookNum;
  late final String classificationNum;
  late final num topBorrow;
  late final String bookImage;
  late final String bookLink;
  late final String createdAt;
  late final String updatedAt;
  late final num v;

  Book.fromJson(Map<String, dynamic> json){
    id = json['_id'] ?? 0;
    name = json['name'] ?? '';
    amount = json['amount'] ?? '';
    overview = json['overview'] ?? '';
    auther = List.from(json['auther'] ?? '').map((e)=>Auther.fromJson(e)).toList();
    rate = json['rate'] ?? '';
    edition = json['edition'] ?? '';
    pages = json['pages'] ?? 0;
    category = json['category'] ?? '';
    library = json['library'] ?? '';
    type = json['type'] ?? '';
    bookNum = json['bookNum'] ?? '';
    classificationNum = json['classificationNum'] ?? '';
    topBorrow = json['top_Borrow'] ?? '';
    bookImage = json['bookImage'] ?? '';
    bookLink = json['bookLink'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['amount'] = amount;
    _data['overview'] = overview;
    _data['auther'] = auther.map((e)=>e.toJson()).toList();
    _data['rate'] = rate;
    _data['edition'] = edition;
    _data['pages'] = pages;
    _data['category'] = category;
    _data['library'] = library;
    _data['type'] = type;
    _data['bookNum'] = bookNum;
    _data['classificationNum'] = classificationNum;
    _data['top_Borrow'] = topBorrow;
    _data['bookImage'] = bookImage;
    _data['bookLink'] = bookLink;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = v;
    return _data;
  }
}

class Auther {
  Auther({
    required this.name,
    required this.id,
  });
  late final String name;
  late final String id;

  Auther.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['_id'] = id;
    return data;
  }
}