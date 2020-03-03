import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qirtasiye_delivery/locale/app_localization.dart';
import 'package:qirtasiye_delivery/model/User.dart';
import 'package:http/http.dart' as http;

class ProfileSettingsDialog extends StatefulWidget {
  VoidCallback onChanged;
  User user;

  ProfileSettingsDialog({Key key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();
  int value = 1;

  update() async {
    final response = await http
        //.post("https://www.qirtasiye.com/api/updateProfile.php",
        .post("http://192.168.86.1/Qirtasiye-Delivery/updateProfile.php",
            body: {
          "id": widget.user.id,
          "email": widget.user.email,
          "password": widget.user.password,
          "name": widget.user.name,
          "phone": widget.user.phone
        });

    final data = jsonDecode(response.body);
    value = data['value'];
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text(
                      AppLocalization.of(context).profileSettings,
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'John Doe',
                              labelText: AppLocalization.of(context).fullname),
                          initialValue: widget.user.name,
                          validator: (input) => input.trim().length < 3
                              ? 'Not a valid full name'
                              : null,
                          onSaved: (input) => widget.user.name = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(
                              hintText: 'johndo@gmail.com',
                              labelText: AppLocalization.of(context).email),
                          initialValue: widget.user.email,
                          validator: (input) =>
                              !input.contains('@') ? 'Not a valid email' : null,
                          onSaved: (input) => widget.user.email = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: getInputDecoration(
                            hintText: '******',
                            labelText: AppLocalization.of(context).password,
                          ),
                          initialValue: widget.user.password,
                          validator: (input) => input.length < 3
                              ? 'Should be more than 3 characters'
                              : null,
                          onSaved: (input) => widget.user.password = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: '+136 269 9765',
                              labelText: AppLocalization.of(context).phone),
                          initialValue: widget.user.phone,
                          validator: (input) => input.trim().length < 3
                              ? 'Not a valid phone'
                              : null,
                          onSaved: (input) => widget.user.phone = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'Your Address',
                              labelText: AppLocalization.of(context).address),
                          initialValue: widget.user.address,
                          validator: (input) => input.trim().length < 3
                              ? 'Not a valid address'
                              : null,
                          onSaved: (input) => widget.user.address = input,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalization.of(context).cancel),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          AppLocalization.of(context).save,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Text(
        AppLocalization.of(context).edit,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      update();
      if (value == 1) {
        widget.onChanged();
        Navigator.pop(context);
      }
    }
  }
}