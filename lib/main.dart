// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dbHelper/mongodb.dart';
import 'myhomepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // calling database connect when app start inside main
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Sign Up UI',
        home: MyHomePage());
  }
}
