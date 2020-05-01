import 'package:chatify/pages/login.page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatify',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(42, 117, 188, 1),
        accentColor: Color.fromRGBO(42, 117, 188, 1),
        backgroundColor: Color.fromRGBO(20, 27, 27, 1),
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}