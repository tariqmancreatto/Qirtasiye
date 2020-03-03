import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:qirtasiye_delivery/locale/app_localization.dart';
import 'package:qirtasiye_delivery/model/LocaleModel.dart';
import 'package:qirtasiye_delivery/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CircularLoadingWidget.dart';

class DrawerWidget extends StatefulWidget {
  User user;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();

  DrawerWidget({this.user});
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: widget.user == null
          ? CircularLoadingWidget(height: 500)
          : Container(
              //color: Colors.grey[200],
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/body.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/Home', arguments: {'user': widget.user});
                    },
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                        image: DecorationImage(
                          image: AssetImage('assets/header.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      accountName: Text(
                        widget.user.name,
                        style: Theme.of(context).textTheme.title,
                      ),
                      accountEmail: Text(
                        widget.user.email,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(widget.user.image),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/Home', arguments: {'user': widget.user});
                    },
                    leading: Icon(
                      Icons.notifications,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      AppLocalization.of(context).notification,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      AppLocalization.of(context).applicationPreferences,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    trailing: Icon(
                      Icons.remove,
                      color: Theme.of(context).focusColor.withOpacity(0.3),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      //Navigator.of(context).pushNamed('/Help');
                    },
                    leading: Icon(
                      Icons.help,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      AppLocalization.of(context).help,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Settings',
                          arguments: {'user': widget.user});
                    },
                    leading: Icon(
                      Icons.settings,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      AppLocalization.of(context).settings,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Languages',
                          arguments: {'user': widget.user});
                    },
                    leading: Icon(
                      Icons.translate,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      AppLocalization.of(context).languages,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                      AppLocalization.load(Locale('en', ''));
                      Provider.of<LocaleModel>(context, listen: false)
                          .changelocale(Locale('en'));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/Login', (Route<dynamic> route) => false);
                    },
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      AppLocalization.of(context).logout,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      AppLocalization.of(context).version + " 0.0.1",
                      style: Theme.of(context).textTheme.body1,
                    ),
                    trailing: Icon(
                      Icons.remove,
                      color: Theme.of(context).focusColor.withOpacity(0.3),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/footer.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}