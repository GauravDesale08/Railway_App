import 'package:flutter/material.dart';
import 'package:hack1/history.dart';
import 'package:hack1/login.dart';
import 'package:hack1/route_model.dart';
import 'package:hack1/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SecondScreen(),
      //LoginTwoPage(key: null,),
    );
  }
}
