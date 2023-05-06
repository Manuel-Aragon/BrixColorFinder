import 'package:flutter/material.dart';

import 'package:lucky13capstone/styles.dart';
import 'package:lucky13capstone/login_page.dart';
import 'package:lucky13capstone/classifier/lego_recognizer.dart';

// This will be the first page the user sees if they are not logged in
class AboutPage extends StatefulWidget {
  // The LandingPage constructor.
  const AboutPage({Key? key}) : super(key: key);

  // This method creates the state for the LandingPage.
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                //checks to see which theme we are using and chooses approriate image
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/images/logo1_dark.png'
                    : 'assets/images/logo1.png',
              ),
              const Divider(),
              const Text(
                  "Developed by: \n-Katherine Aquilone \n-Manuel Aragon \n-Miguel Hernandez, \n-Sam Nyath \n-Shellie Pham \n-Garret Prestidge \n-Muzhda Wahedi",
                  style: TextStyle(
                      fontFamily: kDisplayFont,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
              const Divider(),
              const Text(
                  "Developed for senior capstone at the University of North Texas",
                  style: kResultRatingTextStyle),
              const Divider(),
              const Text(
                  "LEGO® is a trademark of the LEGO Group of companies which does not sponsor, authorize or endorse this app",
                  style: kResultRatingTextStyle),
            ]),
      ),
    );
  }
}
