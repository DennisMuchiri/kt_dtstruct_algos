import 'package:flutter/cupertino.dart';

Widget invisibleWidget() {
  return Visibility(
    visible: false,
    child: SizedBox(
      height: 0,
      width: 0,
    ),
  );
}