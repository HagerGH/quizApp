import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quizapp/screens/quiz/quizscreen.dart';
import 'package:quizapp/screens/result/resultscreen.dart';
import 'package:quizapp/screens/welcome.dart';
import 'package:quizapp/utiles/binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      initialBinding :BilndingsApp(),
    getPages: [
    GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen()),
    GetPage(name: QuizScreen.routeName, page: () =>  QuizScreen()),
    GetPage(name: ResultScreen.routeName, page: () =>  ResultScreen()),
    ],
      home: WelcomeScreen(),
    );
  }
}
