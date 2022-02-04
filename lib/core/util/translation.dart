class TranslationModel {
  late String changeLanguage;
  late String logIn;

  TranslationModel.fromJson(Map<String, dynamic> json) {
    changeLanguage = json['changeLanguage'];
    logIn = json['logIn'];
  }
}
