import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'element/CircularLoadingWidget.dart';
import 'element/DrawerWidget.dart';
import 'element/ProfileSettingsDialog.dart';
import 'locale/app_localization.dart';
import 'model/LocaleModel.dart';
import 'model/User.dart';

class SettingsWidget extends StatefulWidget {
  User user;

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();

  SettingsWidget({this.user});
}

class _SettingsWidgetState extends StateMVC<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _con.scaffoldKey,
      appBar: AppBar(
        //backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          AppLocalization.of(context).settings,
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: DrawerWidget(user: widget.user),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/body.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          widget.user == null
              ? CircularLoadingWidget(height: 500)
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    widget.user.name,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.display2,
                                  ),
                                  Text(
                                    widget.user.email,
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            SizedBox(
                                width: 55,
                                height: 55,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(300),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/Tabs', arguments: 1);
                                  },
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(widget.user.image),
                                    backgroundColor: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.15),
                                offset: Offset(0, 3),
                                blurRadius: 10)
                          ],
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          primary: false,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(
                                AppLocalization.of(context).profileSettings,
                                style: Theme.of(context).textTheme.body2,
                              ),
                              trailing: ButtonTheme(
                                padding: EdgeInsets.all(0),
                                minWidth: 50.0,
                                height: 25.0,
                                child: ProfileSettingsDialog(
                                  user: widget.user,
                                  onChanged: () {},
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              dense: true,
                              title: Text(
                                AppLocalization.of(context).fullname,
                                style: Theme.of(context).textTheme.body1,
                              ),
                              trailing: Text(
                                widget.user.name,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              dense: true,
                              title: Text(
                                AppLocalization.of(context).email,
                                style: Theme.of(context).textTheme.body1,
                              ),
                              trailing: Text(
                                widget.user.email,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              dense: true,
                              title: Text(
                                AppLocalization.of(context).phone,
                                style: Theme.of(context).textTheme.body1,
                              ),
                              trailing: Text(
                                widget.user.phone,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              dense: true,
                              title: Text(
                                AppLocalization.of(context).address,
                                style: Theme.of(context).textTheme.body1,
                              ),
                              trailing: Text(
                                widget.user.address,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.15),
                                offset: Offset(0, 3),
                                blurRadius: 10)
                          ],
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          primary: false,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.settings),
                              title: Text(
                                AppLocalization.of(context).settings,
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed('/Languages',
                                    arguments: {'user': widget.user});
                              },
                              dense: true,
                              title: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.translate,
                                    size: 22,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    AppLocalization.of(context).languages,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ],
                              ),
                              trailing: Text(
                                Provider.of<LocaleModel>(context).langunageName,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                //Navigator.of(context).pushNamed('/Help');
                              },
                              dense: true,
                              title: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.help,
                                    size: 22,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    AppLocalization.of(context).help,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
