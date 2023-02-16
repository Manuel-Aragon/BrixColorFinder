import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'package:lucky13capstone/history_page.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';

import 'package:flutter/foundation.dart';

import 'package:tflite/tflite.dart';

const kModelName = "base-model";

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  bool isCameraReady = false;
  bool isPhotoInProgress = false;

  @override
  void initState() {
    super.initState();
    _getCamera();
  }

  //gets the first available camera from user's device
  void _getCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _controller.initialize();
    setState(() {
      isCameraReady = true;
    });

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size.

    return Scaffold(
        // Disable the bottom inset to avoid resizing the layout when the keyboard appears.
        resizeToAvoidBottomInset: false,
        // Set the background color to white.
        backgroundColor: Colors.white,
        // Use an AppBar at the top of the screen.
        appBar: AppBar(
          title: const Text("Scan"),
        ),
        body: Stack(children: <Widget>[
          Positioned.fill(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Align(
            alignment: const Alignment(0, -1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 100,
                  onPressed: () {
                    // Navigate to the settings page when the settings icon is pressed.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    );
                  },
                  icon: const Icon(Icons.settings, color: Colors.white),
                ),
                IconButton(
                  iconSize: 100,
                  onPressed: () {
                    // Navigate to the history page when the history icon is pressed.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryPage()),
                    );
                  },
                  icon: const Icon(Icons.access_time, color: Colors.white),
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: FloatingActionButton.large(
              // Provide an onPressed callback.
              onPressed: () async {
                // Take the Picture in a try / catch block. If anything goes wrong,
                // catch the error.
                try {
                  // Ensure that the camera is initialized.
                  await _initializeControllerFuture;

                  // Attempt to take a picture and get the file `image`
                  // where it was saved.
                  final image = await _controller.takePicture();

                  if (!mounted) return;

                  // If the picture was taken, display it on a new screen.
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayModelScreen(
                        // Pass the automatically generated path to
                        // the DisplayPictureScreen widget.
                        imagePath: image.path,
                      ),
                    ),
                  );
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ]));
  }
}

List recognitionsList = [];

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}

class DisplayModelScreen extends StatelessWidget {
  final String imagePath;

  const DisplayModelScreen({Key? key, required this.imagePath})
      : super(key: key);

  Future<void> runModel() async {
    recognitionsList = (await Tflite.detectObjectOnImage(
      path: imagePath,
      numResultsPerClass: 1,
      threshold: 0.4,
    ))!;
  }

  void onSaveButtonPressed() {
    // TODO: implement image saving logic
    // Image should be taken at this point, so add the information to the scan history lists
    HistoryState()
        .updateHistory('NewBlock', 'NewColor', 'assets/images/2x2BrickRed.PNG');
    /*HistoryState().color.add('NewColor'); // placeholder values
    HistoryState().block.add('NewBlock');
    HistoryState().image.add(Image.asset(
          'assets/images/2x2BrickRed.PNG',
          width: 200.0,
          height: 200.0,
          fit: BoxFit.contain,
        ));*/
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
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

    loadModel();
    runModel();

    list.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height - 100,
        child: SizedBox(
          height: size.height - 100,
          child: Image.file(
            File(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    list.addAll(displayBoxesAroundRecognizedObjects(size));

    return Scaffold(
      appBar: AppBar(title: const Text('ML model')),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          color: Colors.black,
          child: Stack(
            children: list,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.close)),
              FloatingActionButton(
                  onPressed: () {
                    onSaveButtonPressed(); //pressing the save button should save the results of the scan and send them to the scan history
                  },
                  child: const Icon(Icons.save))
            ]),
      ),
    );
  }
}
