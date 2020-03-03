import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'element/DrawerWidget.dart';
import 'locale/app_localization.dart';
import 'model/Language.dart';
import 'model/LocaleModel.dart';
import 'model/User.dart';

class LanguagesWidget extends StatefulWidget {
  User user;

  @override
  _LanguagesWidgetState createState() => _LanguagesWidgetState();

  LanguagesWidget({this.user});
}

class _LanguagesWidgetState extends State<LanguagesWidget> {
  LanguagesList languagesList;

  @override
  void initState() {
    languagesList = new LanguagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          AppLocalization.of(context).languages,
          style: TextStyle(color: Colors.white),
        ),
        /*actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Colors.white,
              labelColor: Colors.red),
        ],*/
      ),
      drawer: DrawerWidget(
        user: widget.user,
      ),
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
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBarWidget(),
              ),
              SizedBox(height: 15),*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.translate,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      AppLocalization.of(context).appLanguage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display1,
                    ),
                    subtitle: Text(AppLocalization.of(context).languageMessage),
                  ),
                ),
                SizedBox(height: 10),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: languagesList.languages.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    Language _language =
                        languagesList.languages.elementAt(index);
                    return InkWell(
                      onTap: () {
                        AppLocalization.load(Locale(_language.code, ''));
                        if (_language.code != 'ckb')
                          Provider.of<LocaleModel>(context, listen: false)
                              .changelocale(Locale(_language.code));
                        languagesList.languages.forEach((_l) {
                          setState(() {
                            _l.selected = false;
                          });
                        });
                        _language.selected = !_language.selected;
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(0, 2)),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    image: DecorationImage(
                                        image: AssetImage(_language.flag),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  height: _language.selected ? 40 : 0,
                                  width: _language.selected ? 40 : 0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: Colors.grey.withOpacity(
                                        _language.selected ? 0.85 : 0),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: _language.selected ? 24 : 0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _language.englishName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  Text(
                                    _language.localName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
