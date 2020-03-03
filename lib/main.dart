import 'package:provider/provider.dart';
import 'package:qirtasiye_delivery/RouteGenerator.dart';
import 'package:flutter/material.dart';
import 'locale/app_localization.dart';
import 'login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'model/LocaleModel.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => new LocaleModel(),
        child: Consumer<LocaleModel>(
          builder: (context, provider, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginWidget(),
            //initialRoute: '/Login',
            onGenerateRoute: RouteGenerator.generateRoute,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizationDelegate(Locale('en', 'US')) // default
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('ar', ''),
              const Locale('tr', ''),
              const Locale('ckb', ''),
            ],
            locale: Provider.of<LocaleModel>(context).locale,
          ),
        ),
      ),
    );