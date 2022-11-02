import 'package:flutter/material.dart';

class BrickView extends StatefulWidget {
  const BrickView({Key? key}) : super(key: key);

  @override
  State<BrickView> createState() => _BrickViewState();
}

class _BrickViewState extends State<BrickView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("BrickView"),
      ),
      bottomNavigationBar: BottomAppBar(  //nav bar to hold return button
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child : ElevatedButton( //return button
            child: const Text('Go back to home screen'),
            onPressed: () {
                Navigator.pop(context);
            },
          ),  //elevated button
          ),//container
      ),//bottonNavigationBar
    );
  }
}