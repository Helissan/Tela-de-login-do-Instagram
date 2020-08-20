import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuapp/login-widget.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(       
        backgroundColor: Colors.black,
      body: MyLoginPage(),
      )
    );
  }
}

class MyLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(child: WidgetLogin())
      ],
    );
  }
}