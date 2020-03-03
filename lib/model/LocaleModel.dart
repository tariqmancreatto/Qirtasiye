import 'package:flutter/cupertino.dart';

class LocaleModel with ChangeNotifier {
  Locale locale = Locale('en');
  String langunageName = 'English';

  Locale get getlocale => locale;

  void changelocale(Locale l) {
    locale = l;
    if (locale.toString() == 'ar')
      langunageName = 'العربية';
    else if (locale.toString() == 'tr')
      langunageName = 'Türkçe';
    else if (locale.toString() == 'ckb')
      langunageName = 'الكوردية';
    else
      langunageName = 'English';
    notifyListeners();
  }
}