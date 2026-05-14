import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations());
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get email => 'Email';
  String get password => 'Mot de passe';
  String get login => 'Se connecter';
  String get forgotPassword => 'Mot de passe oublié ?';
  String get resetEmailSent => 'Lien de réinitialisation envoyé';
  String get age => 'Âge';
  String get ageMinError => 'Vous devez avoir au moins 18 ans';
  String get settings => 'Paramètres';
  String get language => 'Langue';
  String get legal => 'Mentions légales';
  String get privacy => 'Politique de confidentialité';
  String get register => 'S\'inscrire';
  String get confirmPassword => 'Confirmer le mot de passe';
  String get verificationCode => 'Code de vérification';
  String get resendCode => 'Renvoyer le code';
  String get verify => 'Vérifier';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

const List<Locale> supportedLocales = [Locale('fr'), Locale('en')];
const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  AppLocalizationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
