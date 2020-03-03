import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:qirtasiye_delivery/config/app_config.dart' as config;
import 'package:http/http.dart' as http;
import 'package:qirtasiye_delivery/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'element/BlockButtonWidget.dart';
import 'package:get_ip/get_ip.dart';
import 'dart:io';
import 'locale/app_localization.dart';
import 'model/LocaleModel.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String email;
  String password;
  String token;
  String message = '';
  bool hidePassword = true;
  final _key = new GlobalKey<FormState>();
  String _language = "en";
  bool noInternet = false;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    } else {
      setState(() {
        message = '';
      });
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(AppLocalization.of(context).error),
          content: new Text(AppLocalization.of(context).errorMessage1),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(AppLocalization.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  login() async {
    String ipAddress = await GetIp.ipAddress;
    final response = await http
        .post("http://192.168.86.1/Qirtasiye-Delivery/login.php", body: {
      //.post("https://www.qirtasiye.com/api/login.php", body: {
      "email": email,
      "password": password,
      "token": token,
      "ip": ipAddress
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String emailAPI = data['email'];
    String nameAPI = data['name'];
    String id = data['id'];
    String phone = data['phone'];
    String image;
    if (data['image'] != '')
      image = "https://www.qirtasiye.com/images/kullanici/" + data['image'];
    else
      image =
          "https://www.pngitem.com/pimgs/m/272-2720656_user-profile-dummy-hd-png-download.png";

    if (value == 1) {
      setState(() {
        savePref(value, emailAPI, nameAPI, id, password, phone, image);
      });
      Navigator.of(context).pushReplacementNamed('/Home', arguments: {
        'user': new User(
            id: id,
            name: nameAPI,
            email: emailAPI,
            password: password,
            phone: phone,
            image: image,
            deviceToken: '',
            address: '')
      });
    } else {
      setState(() {
        message = AppLocalization.of(context).errorMessage2;
      });
    }
  }

  savePref(int value, String email, String name, String id, String password,
      String phone, String image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("password", password);
      preferences.setString("phone", phone);
      preferences.setString("image", image);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  Future<void> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        checkAlreadyLogin();
      }
    } on SocketException catch (_) {
      _showDialog();
      setState(() {
        noInternet = true;
      });
    }
  }

  Future<void> checkAlreadyLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('name');

    if (name != null) {
      final String email = prefs.getString('email');
      final String password = prefs.getString('password');
      final String phone = prefs.getString('phone');
      final String image = prefs.getString('image');
      final String id = prefs.getString('id');

      Navigator.of(context).pushReplacementNamed('/Home', arguments: {
        'user': new User(
            id: id,
            name: name,
            email: email,
            password: password,
            phone: phone,
            image: image,
            deviceToken: '',
            address: '')
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        this.token = token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //key: _key,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(27),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Background-logo.png'),
                    ),
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(37) - 75,
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.blue, width: 3),
                  /*boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                      )
                    ]*/
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                width: config.App(context).appWidth(90),
                height: message == ''
                    ? config.App(context).appHeight(65)
                    : config.App(context).appHeight(68),
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          //width: config.App(context).appWidth(84),
                          //height: config.App(context).appHeight(37),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            AppLocalization.of(context).welcome,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => email = input,
                          validator: (input) => !input.contains('@')
                              ? 'Should be a valid email'
                              : null,
                          decoration: InputDecoration(
                            labelText: AppLocalization.of(context).email,
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'johndoe@gmail.com',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.alternate_email,
                                color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2)),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => password = input,
                          validator: (input) => input.length < 3
                              ? 'Should be more than 3 characters'
                              : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            labelText: AppLocalization.of(context).password,
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: '••••••••••••',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.lock_outline,
                                color: Theme.of(context).accentColor),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context).focusColor,
                              icon: Icon(hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 15),
                        BlockButtonWidget(
                          text: Text(
                            AppLocalization.of(context).login,
                            style: TextStyle(fontSize: 20),
                            //style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: noInternet == true ? null : check,
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: _language,
                              value: "en",
                              onChanged: (String value) {
                                AppLocalization.load(Locale(value, 'US'));
                                Provider.of<LocaleModel>(context, listen: false)
                                    .changelocale(Locale(value));
                                setState(() {
                                  _language = value;
                                });
                              },
                            ),
                            Text('English'),
                            SizedBox(
                              width: 120,
                            ),
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: _language,
                              value: "ar",
                              onChanged: (String value) {
                                AppLocalization.load(Locale(value, ''));
                                Provider.of<LocaleModel>(context, listen: false)
                                    .changelocale(Locale(value));
                                setState(() {
                                  _language = value;
                                });
                              },
                            ),
                            Text('العربية'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: _language,
                              value: "tr",
                              onChanged: (String value) {
                                AppLocalization.load(Locale(value, ''));
                                Provider.of<LocaleModel>(context, listen: false)
                                    .changelocale(Locale(value));
                                setState(() {
                                  _language = value;
                                });
                              },
                            ),
                            Text('Türkçe'),
                            SizedBox(
                              width: 120,
                            ),
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: _language,
                              value: "ckb",
                              onChanged: (String value) {
                                AppLocalization.load(Locale(value, ''));
                                setState(() {
                                  _language = value;
                                });
                              },
                            ),
                            Text('كوردى'),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Calibri',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}