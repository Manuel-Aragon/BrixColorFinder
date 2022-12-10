import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/dev_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initialize firebase

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DevPage(title: 'Dev Page'),
  ));
}
