import 'package:flutter/material.dart';
import 'package:tomate_timer/study_session/presenter/UI/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomate Timer',
      theme:
          ThemeData(primaryColor: Colors.redAccent, buttonColor: Colors.green),
      home: MainPage(),
    );
  }
}
