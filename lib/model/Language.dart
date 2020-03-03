class Language {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;

  Language(this.code, this.englishName, this.localName, this.flag,
      {this.selected = false});
}

class LanguagesList {
  List<Language> _languages;

  LanguagesList() {
    this._languages = [
      new Language("en", "English", "English", "assets/Britain.png",
          selected: false),
      new Language("ar", "العربية", "العربية", "assets/Iraq.png",
          selected: false),
      new Language("ckb", "الكوردية", "الكوردية", "assets/Kurdistan.png",
          selected: false),
      new Language("tr", "Türkçe", "Türkçe", "assets/Turkey.png",
          selected: false),
    ];
  }

  List<Language> get languages => _languages;
}