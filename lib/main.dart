import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/dev_page.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initialize firebase
  //cameras = await availableCameras();
  runApp(BrickFinder());
}

class BrickFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //theme: ThemeData.dark(),
      home: DevPage(title: 'Dev Page'),
    );
  }
}

//List<CameraDescription> cameras;
