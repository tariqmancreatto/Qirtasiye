import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // list of locales
  String get welcome {
    return Intl.message(
      'Welcome to Qirtasiye Delivery Application!',
      name: 'welcome',
      desc: '',
    );
  }

  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
    );
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
    );
  }

  String get error {
    return Intl.message(
      'Error!',
      name: 'error',
      desc: '',
    );
  }

  String get errorMessage1 {
    return Intl.message(
      'Please check your internet connection',
      name: 'errorMessage1',
      desc: '',
    );
  }

  String get errorMessage2 {
    return Intl.message(
      'Invalid Login Information, Please check your email and password and try again',
      name: 'errorMessage2',
      desc: '',
    );
  }

  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
    );
  }

  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
    );
  }

  String get help {
    return Intl.message(
      'Help & Support',
      name: 'help',
      desc: '',
    );
  }

  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
    );
  }

  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
    );
  }

  String get fullname {
    return Intl.message(
      'Full Name',
      name: 'fullname',
      desc: '',
    );
  }

  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
    );
  }

  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
    );
  }

  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
    );
  }

  String get appTitle {
    return Intl.message(
      'Qirtasiye Delievery App',
      name: 'appTitle',
      desc: '',
    );
  }

  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
    );
  }

  String get orderStatus {
    return Intl.message(
      'Status : ',
      name: 'orderStatus',
      desc: '',
    );
  }

  String get orderPrice {
    return Intl.message(
      'Price : \$',
      name: 'orderPrice',
      desc: '',
    );
  }

  String get orderQuantity {
    return Intl.message(
      'Quantity : ',
      name: 'orderQuantity',
      desc: '',
    );
  }

  String get customerAddress {
    return Intl.message(
      'Customer Address : ',
      name: 'customerAddress',
      desc: '',
    );
  }

  String get customerName {
    return Intl.message(
      'Customer Name : ',
      name: 'customerName',
      desc: '',
    );
  }

  String get markAsDelivered {
    return Intl.message(
      'Mark as delievered',
      name: 'markAsDelivered',
      desc: '',
    );
  }

  String get applicationPreferences {
    return Intl.message(
      'Application Preferences',
      name: 'applicationPreferences',
      desc: '',
    );
  }

  String get profileSettings {
    return Intl.message(
      'Profile Settings',
      name: 'profileSettings',
      desc: '',
    );
  }

  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
    );
  }

  String get appLanguage {
    return Intl.message(
      'App Language',
      name: 'appLanguage',
      desc: '',
    );
  }

  String get languageMessage {
    return Intl.message(
      'Select your preferred language',
      name: 'languageMessage',
      desc: '',
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'tr', 'ckb'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}