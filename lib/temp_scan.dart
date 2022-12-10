import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'package:lucky13capstone/history_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size.
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        // Disable the bottom inset to avoid resizing the layout when the keyboard appears.
        resizeToAvoidBottomInset: false,
        // Set the background color to white.
        backgroundColor: Colors.white,
        // Use an AppBar at the top of the screen.
        appBar: AppBar(
          title: const Text("Scan"),
        ),
        body: Column(children: [
          // Create a row with two icons.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // Navigate to the settings page when the settings icon is pressed.
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
                  // Navigate to the history page when the history icon is pressed.
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
          // Use the screen size to adjust the height of the middle column.
          SizedBox(height: screenSize.height / 2),
          Column(
              // Create rows with labels and boxes for displaying results.
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
                            // Set the color of the box.
                            color: Color.fromARGB(255, 221, 221, 221)),
                      ),
                    ),
                  ],
                )
              ]),
        ]));
  }
}
