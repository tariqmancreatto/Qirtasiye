import 'package:flutter/material.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget(
      {Key key,
      @required this.color,
      @required this.text,
      @required this.onPressed})
      : super(key: key);

  final Color color;
  final Text text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        color: this.color,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: this.text,
      ),
    );
  }
}