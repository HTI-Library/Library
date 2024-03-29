class SavedBooksModel {
  final String message;

  const SavedBooksModel({
    required this.message,
  });

  factory SavedBooksModel.fromJson(Map<String, dynamic> json) {
    return SavedBooksModel(
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
