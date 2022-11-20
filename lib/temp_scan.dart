import 'package:flutter/material.dart';
import 'package:lucky13capstone/brickview.dart';
import 'settings.dart';
import 'package:lucky13capstone/history.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Scan"),
      ),
     body:  Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
              child: Column(
                children: <Widget>[
                  ElevatedButton( //settings
                    child: const Text('Settings'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsPage()),
                          );
                        },
                  ),
                  ElevatedButton( //brick view
                    child: const Text('History'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HistoryPage()),
                          );
                        },
                  ),
                  ElevatedButton( //brick view
                    child: const Text('Brick View'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BrickView()),
                          );
                        },
                  ),
                ],
              ),
      ),
    );
  }
}