class TranslationModel {
  late String changeLanguage;
  late String logIn;
  late String arabic;
  late String english;

  TranslationModel.fromJson(Map<String, dynamic> json) {
    changeLanguage = json['changeLanguage'];
    logIn = json['logIn'];
    arabic = json['arabic'];
    english = json['english'];
  }
}
