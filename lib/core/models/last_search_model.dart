class LastSearchModel {
  List<LastSearchData>? last_search;

  LastSearchModel({
    required this.last_search,
  });

  factory LastSearchModel.fromJson(Map<String, dynamic> json) {
    return LastSearchModel(
      last_search: List.from(json['last_search']).map((e) => LastSearchData.fromJson(e)).toList(),
    );
  }

}

class LastSearchData {
  LastSearchData({
    required this.word,
    required this.id,
  });

  late final String word;
  late final String id;

  LastSearchData.fromJson(Map<String, dynamic> json) {
    word = json['word'] ?? '';
    id = json['_id'] ?? '';
  }
}