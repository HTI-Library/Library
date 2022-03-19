class AllReturned {
  AllReturned({
    required this.books,
    required this.allBooks,
  });
  late final List<Books> books;
  late final int allBooks;

  AllReturned.fromJson(Map<String, dynamic> json){
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
    required this.id,
    required this.userId,
    required this.bookId,
    required this.startDate,
    required this.endDate,
    required this.returnedDate,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String userId;
  late final String bookId;
  late final String startDate;
  late final String endDate;
  late final String returnedDate;
  late final String createdAt;
  late final String updatedAt;

  Books.fromJson(Map<String, dynamic> json){
    id = json['_id'] ?? '';
    userId = json['user_id'] ?? '';
    bookId = json['book_id'] ?? '';
    startDate = json['startDate'] ?? '';
    endDate = json['endDate'] ?? '';
    returnedDate = json['returned_date'] ?? '';
    createdAt = json['createdAt'] ?? '' ;
    updatedAt = json['updatedAt']?? '' ;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['user_id'] = userId;
    _data['book_id'] = bookId;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['returned_date'] = returnedDate;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}