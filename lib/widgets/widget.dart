import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.png",
      height: 50,
    ),
  );
}

Container button(BuildContext context, String text) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xff007EF4), const Color(0xff2A75BC)]),
        borderRadius: BorderRadius.circular(30)),
    margin: EdgeInsets.symmetric(vertical: 16),
    child: Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
}
