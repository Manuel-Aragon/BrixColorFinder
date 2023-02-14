import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

const kModelName = "base-model";

class ModelPage extends StatefulWidget {
  const ModelPage({Key? key}) : super(key: key);
  @override
  State<ModelPage> createState() => _ModelPageState();
}

late XFile? pickedFile;
late List recognitionsList;

class _ModelPageState extends State<ModelPage> {
  initImagePicker() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    runModel();
  }

  runModel() async {
    recognitionsList = (await Tflite.detectObjectOnImage(
      path: pickedFile!.path,
      numResultsPerClass: 1,
      threshold: 0.4,
    ))!;

    setState(() {});
  }

  Future loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    initImagePicker();
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    double factorX = screen.width;
    double factorY = screen.height;

    Color colorPick = Colors.pink;

    return recognitionsList.map((result) {
      return Positioned(
        left: result["rect"]["x"] * factorX,
        top: result["rect"]["y"] * factorY,
        width: result["rect"]["w"] * factorX,
        height: result["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> list = [];

    list.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height - 100,
        child: SizedBox(
          height: size.height - 100,
          child: (pickedFile == null)
              ? Container()
              : Image.file(
                  File(pickedFile!.path),
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );

    list.addAll(displayBoxesAroundRecognizedObjects(size));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('ML model')),
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          color: Colors.black,
          child: Stack(
            children: list,
          ),
        ),
      ),
    );
  }
}
