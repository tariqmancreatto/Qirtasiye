import 'dart:convert';
import 'package:qirtasiye_delivery/element/DrawerWidget.dart';
import 'package:qirtasiye_delivery/model/Order.dart';
import 'package:flutter/material.dart';
import 'element/NotificationItemWidget.dart';
import 'package:http/http.dart' as http;
import 'locale/app_localization.dart';
import 'model/User.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';


class Home extends StatefulWidget {
  User user;

  @override
  _MyAppState createState() => _MyAppState();

  Home({this.user});
}

class _MyAppState extends State<Home> {
  int counter = 0;
  List<Order> orders = [];

  void initNotifications() async {
    if (orders.isEmpty) {
      final response = await http.get(
          "http://192.168.86.1/Qirtasiye-Delivery/getNotifications.php?kuryeID=" +
              widget.user.id);
      final data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        List<String> notificationParts = data[i].split(',');
        Order order = new Order(
            id: notificationParts[0],
            status: notificationParts[1],
            productName: notificationParts[2],
            productQuantity: notificationParts[3],
            productPrice: notificationParts[4],
            address: notificationParts[5],
            customerName: notificationParts[6]);
        setState(() {
          orders.add(order);
          counter++;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initNotifications();
  }

  Future<void> refreshNotification() async {
    counter = 0;
    orders.clear();
    initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalization.of(context).appTitle,
          style: TextStyle(color: Colors.white),
        ),
        //backgroundColor: Colors.purple,
        actions: <Widget>[
          // Using Stack to show Notification Badge
          new Stack(
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    setState(() {
                      counter = 0;
                    });
                  }),
              counter != 0
                  ? new Positioned(
                      right: 11,
                      top: 11,
                      child: new Container(
                        padding: EdgeInsets.all(2),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '$counter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : new Container()
            ],
          ),
        ],
      ),
      drawer: DrawerWidget(
        user: widget.user,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/body.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: refreshNotification,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    Icons.notifications,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    AppLocalization.of(context).notification,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: orders.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 15);
                  },
                  itemBuilder: (context, index) {
                    return NotificationItemWidget(
                      order: orders.elementAt(index),
                      notifyParent: refreshNotification,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
