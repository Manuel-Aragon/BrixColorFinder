import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:lucky13capstone/home.dart';


void main() async {

    WidgetsFlutterBinding.ensureInitialized(); 
    await Firebase.initializeApp(); 

  // //camera
  // // Obtain a list of the available cameras on the device.
  //final cameras = await availableCameras();

  // // Get a specific camera from the list of available cameras.
  //final firstCamera = cameras.first;

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Home Page'),
      ) //MaterialApp
    ); 
}