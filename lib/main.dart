import 'package:api_first_tutorial/home_screen.dart';
import 'package:api_first_tutorial/signup.dart';
import 'package:api_first_tutorial/upload_image.dart';
import 'package:flutter/material.dart';
import 'example_five.dart';
import 'example_four.dart';
import 'example_three.dart';
import 'example_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const UploadImageScreen() ,
    );
  }
}

