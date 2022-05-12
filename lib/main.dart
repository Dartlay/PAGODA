import 'package:flutter/material.dart';
import 'package:pagoda/Screens/homePage.dart';

void main() {
  runApp(Pogodka());
}

class Pogodka extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pogodka',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey, brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
