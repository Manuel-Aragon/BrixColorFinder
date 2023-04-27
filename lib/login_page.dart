//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/classifier/lego_recognizer.dart';
import 'package:lucky13capstone/main.dart';
import 'package:lucky13capstone/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucky13capstone/settings_model.dart';
import 'package:provider/provider.dart';

// This class represents the login page of the app.
class LoginPage extends StatefulWidget {
  // The LoginPage constructor.
  const LoginPage({Key? key}) : super(key: key);

  // This method creates the state for the LoginPage.
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// This class represents the state of the LoginPage.
class _LoginPageState extends State<LoginPage> {
  //controller for the email field in the login form
  final emailController = TextEditingController();
  //controller for the  password field in the login form.
  final passwordController = TextEditingController();
  //This key is used to access the form state.
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  //to hide password
  bool passenable = true;

// This method is called by the _login method to start the authentication process.
  void _authenticate() async {
    try {
      // Call the signInWithEmailAndPassword method to authenticate the user.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // Display an error message to the user
      // or take some other appropriate action
    }
  }

// This method is called when the user clicks the login button.
  void _login() {
    // Check if the form is valid and, if so, call the _authenticate method.
    if (_key.currentState!.validate()) {
      _authenticate();
    }

    // Set up a listener to wait for the user to be authenticated.
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // If the user is authenticated, navigate to the ScanPage.
      if (user != null) {
        context.read<SettingsModel>().loadFromCloud();

        //pushAndRemoveUntil() used so that user can't navigate back after they login
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BrickFinder()),
            (r) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //**top part**
            Image.asset(
              //checks to see which theme we are using and chooses approriate image
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/images/logo1_dark.png'
                  : 'assets/images/logo1.png',
            ),
            const Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),

            //Form
            Form(
              key: _key,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.5,
                              color: Color.fromARGB(223, 212, 89, 100)),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.5,
                              color: Color.fromARGB(223, 212, 89, 100)),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        prefixIcon: const Icon(Icons.person_outline_outlined),
                        labelText: "Email",
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: passenable,
                      controller: passwordController,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.5,
                              color: Color.fromARGB(223, 212, 89, 100)),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.5,
                              color: Color.fromARGB(223, 212, 89, 100)),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        labelText: "Password",
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(passenable
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passenable = !passenable;
                            });
                          },
                        ),
                        alignLabelWithHint: false,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //       onPressed: () {},
                    //       style: TextButton.styleFrom(
                    //         foregroundColor:
                    //             const Color.fromARGB(223, 212, 89, 100),
                    //       ),
                    //       child: const Text(
                    //         "Forgot Password?",
                    //         style: TextStyle(fontSize: 16),
                    //       )),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _login();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                        child: const Text("LOGIN"),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                              text: "Don't have an account?",
                              style:
                                  TextStyle(color: textColor, fontSize: 18.0),
                              children: [
                                TextSpan(
                                  text: " Sign Up",
                                  style: const TextStyle(
                                      color: const Color.fromARGB(
                                          223, 212, 89, 100)),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        )));
  }
}

// Validate an email string and return an error message if invalid.
String? validateEmail(String? formEmail) {
  // Check if input is not null and not empty.
  if (formEmail?.isNotEmpty == true) {
    // Use regex to check for valid email format.
    final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    // Return null if email is valid, otherwise return error message.
    if (emailRegex.hasMatch(formEmail!)) {
      return null;
    }
    return 'Please enter a valid e-mail address.';
  }
  // Return error message if input is null or empty.
  return 'E-mail address is required.';
}

// Validate a password string and return an error message if invalid.
String? validatePassword(String? formPassword) {
  // Return error message if input is null or empty.
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }
  // Return null if input is not null or empty.
  return null;
}
