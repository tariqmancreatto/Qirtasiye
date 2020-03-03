import 'package:qirtasiye_delivery/languages.dart';
import 'package:qirtasiye_delivery/home.dart';
import 'package:qirtasiye_delivery/login.dart';
import 'package:flutter/material.dart';
import 'package:qirtasiye_delivery/settings.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final Map args = settings.arguments as Map;
    switch (settings.name) {
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/Home':
        return MaterialPageRoute(
            builder: (_) => Home(
                  user: args['user'],
                ));
      case '/Settings':
        return MaterialPageRoute(
            builder: (_) => SettingsWidget(
                  user: args['user'],
                ));
      case '/Languages':
        return MaterialPageRoute(
            builder: (_) => LanguagesWidget(
                  user: args['user'],
                ));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}