import 'dart:convert';

import 'package:qirtasiye_delivery/locale/app_localization.dart';
import 'package:qirtasiye_delivery/model/Order.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationItemWidget extends StatefulWidget {
  final Function() notifyParent;

  Order order;

  NotificationItemWidget({Key key, this.order, this.notifyParent})
      : super(key: key);

  @override
  _NotificationItemWidgetState createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  update() async {
    final response = await http.post(
        //"https://www.qirtasiye.com/api/updateOrderStatus.php",
        "http://192.168.86.1/Qirtasiye-Delivery/updateOrderStatus.php",
        body: {"id": widget.order.id});
    final data = jsonDecode(response.body);
    int value = data['value'];
    if (value == 1) widget.notifyParent();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.2,
      duration: Duration(seconds: 1),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.order.status == 'kurye-bekliyor' ||
                  widget.order.status == 'kuryede'
              ? Colors.red
              : Colors.purple,
          width: 3,
        ),
      ),
      child: Column(
        children: <Widget>[
          ExpandablePanel(
            header: widget.order.status == 'kurye-bekliyor' ||
                    widget.order.status == 'kuryede'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: _controller,
                        child: Icon(
                          Icons.notifications,
                          size: 25, //
                        ),
                        builder: (context, widget) => Transform.scale(
                            scale: _controller.value, child: widget),
                      ),
                      Expanded(
                        child: Text(widget.order.productName),
                      ),
                    ],
                  )
                : Text(widget.order.productName),
            collapsed: Text(
              AppLocalization.of(context).orderDetails,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            expanded: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalization.of(context).orderStatus + widget.order.status,
                  softWrap: true,
                ),
                Text(
                  AppLocalization.of(context).orderPrice +
                      widget.order.productPrice,
                  softWrap: true,
                ),
                Text(
                  AppLocalization.of(context).orderQuantity +
                      widget.order.productQuantity,
                  softWrap: true,
                ),
                Text(
                  AppLocalization.of(context).address + widget.order.address,
                  softWrap: true,
                ),
                Text(
                  AppLocalization.of(context).customerName +
                      widget.order.customerName,
                  softWrap: true,
                ),
              ],
            ),
          ),
          RaisedButton(
              child: Text(AppLocalization.of(context).markAsDelivered),
              onPressed: widget.order.status == 'kurye-bekliyor' ||
                      widget.order.status == 'kuryede'
                  ? update
                  : null),
        ],
      ),
    );
  }
}