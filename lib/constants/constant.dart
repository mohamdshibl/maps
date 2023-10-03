import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



void navigateToAndStop(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget,),
        (Route<dynamic> route) => false,
  );
}

Widget defaultSeparatorContainer() {
  return Container(
    width: double.infinity,
    height: 4,
    color: Colors.grey[300],
  );
}


