import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                },
                icon: const Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryPage()),
                  );
                },
                icon: const Icon(Icons.access_time),
              ),
            ],
          ),
          const SizedBox(height: 450),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Shape      '),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Dimension'),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Color        '),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('SCAN'),
          ),
        ],
      ),
    );
  }
}
