class RemoveSavedBooksModel {
  final List<BookRemoveData>? books;
  final String message;

  const RemoveSavedBooksModel({
    required this.books,
    required this.message,
  });

  factory RemoveSavedBooksModel.fromJson(Map<String, dynamic> json) {
    return RemoveSavedBooksModel(
      books:
      List.from(json['books']).map((e) => BookRemoveData.fromJson(e)).toList(),
      message: json['message'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'books': books,
      'message': message,
    };
  }
}

class BookRemoveData {
  late final String book_id;
  late final String _id;

  BookRemoveData.fromJson(Map<String, dynamic> json) {
    book_id = json['book_id'] ?? '';
    _id = json['_id'] ?? '';


  }
}
