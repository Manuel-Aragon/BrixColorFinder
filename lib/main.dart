import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/dev_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initialize firebase
  //cameras = await availableCameras();
  runApp(const BrickFinder());
}

class BrickFinder extends StatelessWidget {
  const BrickFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      theme: ThemeData(
        //scaffoldBackgroundColor: Color.fromARGB(255, 25, 39, 48),
        appBarTheme:
            AppBarTheme(color: const Color.fromARGB(255, 38, 214, 226)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color.fromARGB(
                223, 212, 89, 100), // background (button) color
            foregroundColor: const Color(0xFfffffff), // foreground (text) color
          ),
        ),
      ),
      home: const DevPage(title: 'Dev Page'),
    );
  }
}

//List<CameraDescription> cameras;
