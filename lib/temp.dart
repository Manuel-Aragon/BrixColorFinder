//remove after sprint end
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite/tflite.dart';
// import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';


// const kModelName = "base-model";


// class ModelPage extends StatefulWidget {
//   const ModelPage({Key? key}) : super(key: key);
//   @override
//   State<ModelPage> createState() => _ModelPageState();
// }

// class _ModelPageState extends State<ModelPage> {
//   late CameraController cameraController;
//   late Future<void> _initializeControllerFuture;
//   late CameraImage cameraImage;
//   bool isCameraReady = false;
//   bool isPhotoInProgress = false;
//   late List recognitionsList;


//   @override
//   void initState()
//   {
//     super.initState();
//     _getCamera();
//     initWithLocalModel();
//   }

//    late FirebaseCustomModel model;

//   /// Initially get the lcoal model if found, and asynchronously get the latest one in background.
//   initWithLocalModel() async {
//     final _model = await FirebaseModelDownloader.instance.getModel(
//         kModelName, FirebaseModelDownloadType.localModelUpdateInBackground);

//     setState(() {
//       model = _model;
//     });
//   }

//   //gets the first available camera from user's device
//   void _getCamera() async
//   {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;

//     cameraController = CameraController
//     (
//       firstCamera,
//       ResolutionPreset.max,
//       enableAudio: false,
//     );

//     await cameraController.initialize();
//     setState(()
//     {
//       isCameraReady = true;
//     });

//     _initializeControllerFuture = cameraController.initialize().then((value) {
//       setState(() {
//         cameraController.startImageStream((image) => {
//               cameraImage = image,});
//       });
//     });
//   }
//   Future loadModel() async {
//     Tflite.close();
//      await Tflite.loadModel(
//         model: model.file.path,
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     cameraController.stopImageStream();
//     Tflite.close();
//   }

//   List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
//     if (recognitionsList == null) return [];

//     double factorX = screen.width;
//     double factorY = screen.height;

//     Color colorPick = Colors.pink;

//     return recognitionsList.map((result) {
//       return Positioned(
//         left: result["rect"]["x"] * factorX,
//         top: result["rect"]["y"] * factorY,
//         width: result["rect"]["w"] * factorX,
//         height: result["rect"]["h"] * factorY,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             border: Border.all(color: Colors.pink, width: 2.0),
//           ),
//           child: Text(
//             "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
//             style: TextStyle(
//               background: Paint()..color = colorPick,
//               color: Colors.black,
//               fontSize: 18.0,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     List<Widget> list = [];

//     list.add(
//       Positioned(
//         top: 0.0,
//         left: 0.0,
//         width: size.width,
//         height: size.height - 100,
//         child: Container(
//           height: size.height - 100,
//           child: (!cameraController.value.isInitialized)
//               ? new Container()
//               : AspectRatio(
//                   aspectRatio: cameraController.value.aspectRatio,
//                   child: CameraPreview(cameraController),
//                 ),
//         ),
//       ),
//     );

//     if (cameraImage != null) {
//       list.addAll(displayBoxesAroundRecognizedObjects(size));
//     }

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Container(
//           margin: EdgeInsets.only(top: 50),
//           color: Colors.black,
//           child: Stack(
//             children: list,
//           ),
//         ),
//       ),
//     );
//   }
// }