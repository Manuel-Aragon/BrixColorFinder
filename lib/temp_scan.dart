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
    /* body:  Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
              child: Column(
                children: <Widget>[
                  IconButton(
                  //ElevatedButton( //settings
                    //child: const Text('Setting'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsPage()),
                          );
                        },
                        icon: Icon(Icons.settings),
                  ),
                  IconButton( //brick view
                    //child: const Text('History'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HistoryPage()),
                          );
                        },
                        icon: Icon(Icons.access_time),
                  ),
                 /* ElevatedButton( //brick view
                    child: const Text('Brick View'),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BrickView()),
                          );
                        },
                  ),*/
                  ElevatedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.camera_alt_outlined),
                    label: Text('SCAN'),
                    ), 
                ],
              ),
      ),*/

      /*body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
                   onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                      );
                    },
                    icon: Icon(Icons.settings),
                  ),
                  IconButton( 
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HistoryPage()),
                          );
                        },
                        icon: Icon(Icons.access_time),
                  ),
        ],
      ),*/
     

     /* Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.camera_alt_outlined),
                    label: Text('SCAN'),
                    ), 
                    child:widget
            ),

            */


    body: Column(
      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(
                   onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                      );
                    },
                    icon: Icon(Icons.settings),
                  ),
            IconButton( 
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HistoryPage()),
                          );
                        },
                        icon: Icon(Icons.access_time),
                  ),
              ],
            ),
        SizedBox(height: 450), 

         Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Shape      '),
              SizedBox(
                width: 150,
                height: 40,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 221, 221, 221)),
                ),
              ),
            ],
          ),
          SizedBox(height:10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Dimension'),
              SizedBox(
                width: 150,
                height: 40,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 221, 221, 221)),
                ),
              ),
            ],
          ),
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Color        '),
              SizedBox(
                width: 150,
                height: 40,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 221, 221, 221)),
                ),
              ),
            ],
          ),
          ],
        ),
       SizedBox(height:20),
        ElevatedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.camera_alt_outlined),
                    label: Text('SCAN'),
                    ), 
      ],
    ),

    );
  }
}