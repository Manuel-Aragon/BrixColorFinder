import 'package:flutter/material.dart';
import 'package:lucky13capstone/register.dart';
import 'package:lucky13capstone/login.dart';
import 'package:lucky13capstone/camera.dart';
import 'package:lucky13capstone/settings.dart';

import 'package:lucky13capstone/temp_scan.dart';
import 'package:lucky13capstone/brickview.dart';
import 'package:lucky13capstone/history.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

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

const kModelName = "base-model";


class _HomePageState extends State<HomePage> {
   @override
  void initState() {
    super.initState();
    initWithLocalModel();
  }

  FirebaseCustomModel? model;

  /// Initially get the lcoal model if found, and asynchronously get the latest one in background.
  initWithLocalModel() async {
    final _model = await FirebaseModelDownloader.instance.getModel(
        kModelName, FirebaseModelDownloadType.localModelUpdateInBackground);

    setState(() {
      model = _model;
    });
  }

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
                children: [
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
                    child: const Text('Scan History'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HistoryPage()),
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
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: model != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Model name: ${model!.name}'),
                                  Text('Model size: ${model!.size}'),
                                ],
                              )
                            : const Text("No local model found"),
                        ),
                      ),
                  ),
                                  const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final _model = await FirebaseModelDownloader.instance
                              .getModel(kModelName,
                                  FirebaseModelDownloadType.latestModel);

                          setState(() {
                            model = _model;
                          });
                        },
                        child: const Text('Get latest model'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseModelDownloader.instance
                              .deleteDownloadedModel(kModelName);

                          setState(() {
                            model = null;
                          });
                        },
                        child: const Text('Delete local model'),
                      ),
                    ),
                  ],
                ),   
                ],
            ),
      ),
    );
  }
}