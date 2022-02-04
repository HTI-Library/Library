class TranslationModel {
  late String changeLanguage;

  TranslationModel.fromJson(Map<String, dynamic> json) {
    changeLanguage = json['changeLanguage'];
  }
}
