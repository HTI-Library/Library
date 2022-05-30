class MyBorrowBookModel {
  MyBorrowBookModel({
    required this.books,
    required this.allBooks,
  });
  late final List<Books> books;
  late final int allBooks;

  MyBorrowBookModel.fromJson(Map<String, dynamic> json){
    books = List.from(json['books']).map((e)=>Books.fromJson(e)).toList();
    allBooks = json['allBooks'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['books'] = books.map((e)=>e.toJson()).toList();
    _data['allBooks'] = allBooks;
    return _data;
  }
}

class Books {
  Books({
    required this.book,
    required this.borrowID,
  });
  late final Book book;
  late final String borrowID;

  Books.fromJson(Map<String, dynamic> json){
    book = Book.fromJson(json['book']);
    borrowID = json['borrow_ID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['book'] = book.toJson();
    _data['borrow_ID'] = borrowID;
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
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final num amount;
  late final String overview;
  late final List<Auther> auther;
  late final num rate;
  late final String edition;
  late final num pages;
  late final String category;
  late final String library;
  late final String type;
  late final String bookNum;
  late final String classificationNum;
  late final num topBorrow;
  late final String bookImage;
  late final String createdAt;
  late final String updatedAt;

  Book.fromJson(Map<String, dynamic> json){
    id = json['_id'] ?? '';
    name = json['name'] ?? '';
    amount = json['amount'] ?? 0;
    overview = json['overview'] ?? '';
    auther = List.from(json['auther']).map((e)=>Auther.fromJson(e)).toList();
    rate = json['rate'] ?? '';
    edition = json['edition'] ?? '';
    pages = json['pages'] ?? 0;
    category = json['category'] ?? '';
    library = json['library'] ?? '';
    type = json['type'] ?? '';
    bookNum = json['bookNum'] ?? '';
    classificationNum = json['classificationNum'] ?? '';
    topBorrow = json['top_Borrow'] ?? 0;
    bookImage = json['bookImage'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
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
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
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
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['_id'] = id;
    return _data;
  }
}