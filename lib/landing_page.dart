import 'package:flutter/material.dart';
import 'package:lucky13capstone/landing_page.dart';
import 'package:lucky13capstone/model_page.dart';
import 'package:lucky13capstone/register_page.dart';
import 'package:lucky13capstone/login_page.dart';
import 'package:lucky13capstone/settings_page.dart';
import 'package:lucky13capstone/live_model.dart';
import 'package:lucky13capstone/scan_page.dart';
import 'package:lucky13capstone/brickview_page.dart';
import 'package:lucky13capstone/history_page.dart';
import 'package:lucky13capstone/widget/plant_recogniser.dart';

// This will be the first page the user sees if they are not logged in
class LandingPage extends StatefulWidget {
  // The LandingPage constructor.
  const LandingPage({Key? key}) : super(key: key);

  // This method creates the state for the LandingPage.
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing Page'),
      ),
      body: Center(
        child: Column(children: [
          Image(image: AssetImage('assets/images/logo1.png')),
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
            child: const Text('Continue as Guest'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PlantRecogniser()),
              );
            },
          ),
        ]),
      ),
    );
  }
}
