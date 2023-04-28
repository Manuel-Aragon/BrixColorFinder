import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'notifiers.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationController = TextEditingController();
  bool passenable = true;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Initialize the Firestore instance

// This method is called when the user clicks the register button.
  void _register() async {
    try {
      // Create a new user with the given email and password

      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if the user was created successfully
      final currentUser = authResult.user;
      if (currentUser != null) {
        currentUser.updateDisplayName(nameController.text);
        // Save user information to Firestore
        await _firestore.collection('users').doc(currentUser.uid).set({
          'email': emailController.text,
          'phone': phoneController.text,
          'name': nameController.text,
        });

        // Save user settings to Firestore
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('settings')
            .doc('user_settings')
            .set({
          'dark_mode': false, // default value
          'language': 'en', // default value
        });

        // Navigate to the login page and remove the registration page from the stack
        // Pop all routes except the first one (BrickFinder)
        Navigator.popUntil(context, (route) => route.isFirst);
        // Set the currentIndex to 0 (LegoRecogniser)
        context.read<PageNotifier>().setCurrentIndex(0);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
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
              "Sign Up",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),

            //Input
            Form(
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: validateName,
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
                      labelText: "Full Name",
                      hintText: "Full Name",
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      prefixIcon: const Icon(Icons.mail),
                      labelText: "Email",
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    validator: validatePhone,
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
                      prefixIcon: const Icon(Icons.phone),
                      labelText: "Number",
                      hintText: "Number",
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
                      //filled: true,
                      //fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: passenable,
                    controller: confirmationController,
                    validator: validateConfirmation,
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
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        _register();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                      child: const Text("SIGN UP"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(color: textColor),
                            children: [
                              TextSpan(
                                text: " Login",
                                style: TextStyle(
                                    color: Color.fromARGB(223, 212, 89, 100)),
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ]),
        ),
      ),
    );
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

String? validatePhone(String? formPhone) {
  if (formPhone == null || formPhone.isEmpty) {
    return 'Phone number is required.';
  }
  //other validations go here
  return null;
}

String? validateName(String? formName) {
  if (formName == null || formName.isEmpty) {
    return 'Name is required.';
  }
  //other validations go here
  return null;
}

// Validate a password string and return an error message if invalid.
String? validatePassword(String? formPassword) {
  // Return error message if input is null or empty.
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }
  // Return error message if password is less than 6 characters long.
  if (formPassword.length < 6) {
    return 'Password must be at least 6 characters long.';
  }
  // Return null if input is not null or empty and password is at least 6 characters long.
  return null;
}

String? validateConfirmation(String? formConfirmation) {
  if (formConfirmation == null || formConfirmation.isEmpty) {
    return 'Please confirm your password';
  }
  //other validations go here
  return null;
}

Color getColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black;
}
