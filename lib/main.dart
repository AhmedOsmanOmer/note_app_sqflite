import 'package:flutter/material.dart';
import 'package:note_app_sqflite/add_note.dart';
import 'package:note_app_sqflite/home.dart';
import 'package:note_app_sqflite/login.dart';
import 'package:note_app_sqflite/sign.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  pref=await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home:pref.getString('log')==null?Sign():const Login(),
    );
  }
}
