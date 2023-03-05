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
    return const MaterialApp(
      //theme: ThemeData.dark(),
      home: DevPage(title: 'Dev Page'),
    );
  }
}

//List<CameraDescription> cameras;
