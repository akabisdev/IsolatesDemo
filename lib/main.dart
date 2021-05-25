import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isolates_demo/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IsolateDemo',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
