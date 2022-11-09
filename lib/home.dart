import 'package:flutter/material.dart';
import 'package:lucky13capstone/register.dart';
import 'package:lucky13capstone/login.dart';
import 'package:lucky13capstone/camera.dart';
import 'package:lucky13capstone/settings.dart';

import 'package:lucky13capstone/tempScan.dart';
import 'package:lucky13capstone/brickview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:  Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
              child: Column(
                children: <Widget>[
                  ElevatedButton( //return button
                    child: const Text('Login'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                  ),
                  ElevatedButton( //return button
                    child: const Text('Register'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                          );
                        },
                  ),
                  ElevatedButton( //return button
                    child: const Text('Settings'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsPage()),
                          );
                        },
                  ),
                  ElevatedButton( //return button
                    child: const Text('Brick View'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BrickView()),
                          );
                        },
                  ),
                  ElevatedButton( //return button
                    child: const Text('Scan'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScanPage()),
                          );
                        },
                  ),
                  ElevatedButton( //return button
                    child: const Text('Camera'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TakePictureScreen()),
                          );
                        },
                  ),
                ],
              ),
      ),
    );
  }
}