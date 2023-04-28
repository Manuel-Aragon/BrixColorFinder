import 'package:flutter/material.dart';
import 'package:lucky13capstone/register_page.dart';
import 'package:lucky13capstone/login_page.dart';
import 'package:lucky13capstone/settings_page.dart';
import 'package:lucky13capstone/brickview_page.dart';
import 'package:lucky13capstone/history_page.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'notifiers.dart';
import 'package:provider/provider.dart';

class DevPage extends StatefulWidget {
  const DevPage({super.key, required this.title});
  final String title;

  @override
  State<DevPage> createState() => _DevPageState();
}

const kModelName = "base-model";

class _DevPageState extends State<DevPage> {
  @override
  void initState() {
    super.initState();
    initWithLocalModel();
  }

  FirebaseCustomModel? model;

  /// Initially get the local model if found, and asynchronously get the latest one in background.
  initWithLocalModel() async {
    final localModel = await FirebaseModelDownloader.instance.getModel(
        kModelName, FirebaseModelDownloadType.localModelUpdateInBackground);

    setState(() {
      model = localModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Settings'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Brick View'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BrickView()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Scan History'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Lego Scan'),
              onPressed: () {
                // Set the currentIndex to 0 (LegoRecogniser)
                context.read<PageNotifier>().setCurrentIndex(0);
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
                      final localModel = await FirebaseModelDownloader.instance
                          .getModel(kModelName,
                              FirebaseModelDownloadType.latestModel);
                      setState(() {
                        model = localModel;
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
