class BorrowBookModel {
  final String message;

  BorrowBookModel({
    required this.message,
  });

  factory BorrowBookModel.fromJson(Map<String, dynamic> json) => BorrowBookModel(
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}