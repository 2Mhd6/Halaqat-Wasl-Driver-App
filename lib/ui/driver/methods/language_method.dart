import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class LanguageMethod {

  static void toggleLanguage(BuildContext context) {
    final currentLocale = context.locale;
    if (currentLocale.languageCode == 'en') {
      context.setLocale(const Locale('ar'));
    } else {
      context.setLocale(const Locale('en'));
    }
  }
}