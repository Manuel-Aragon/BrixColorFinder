import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
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

void registerUser(){
  
}