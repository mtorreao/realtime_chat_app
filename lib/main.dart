import 'package:flutter/material.dart';
import 'package:realtime_chat_app/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realtime Chat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
