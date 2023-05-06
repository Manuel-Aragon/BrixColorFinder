//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucky13capstone/settings_model.dart';
import 'package:provider/provider.dart';
import 'notifiers.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({Key? key}) : super(key: key);
  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? currentPasswordError;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //to hide password
  bool passenable = true;
  Future<void> _authenticate() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: FirebaseAuth.instance.currentUser?.email ?? '',
          password: currentPasswordController.text);
    } catch (error) {
      // Check if the error code is 'wrong-password' or 'user-not-found'
      if (error is FirebaseAuthException &&
          (error.code == 'wrong-password' || error.code == 'user-not-found')) {
        throw Exception('The current password is incorrect.');
      } else {
        throw Exception('An error occurred.');
      }
    }
  }

  Future<void> _changePassword() async {
    // Check if the form is valid and, if so, call the _authenticate method.
    if (_key.currentState!.validate()) {
      try {
        await _authenticate();
        await FirebaseAuth.instance.currentUser
            ?.updatePassword(newPasswordController.text);
        // Pop last route
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          currentPasswordError = error.toString();
        });
        _key.currentState!.validate();
      }
    }
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

  String? validateCurrentPassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Current password is required.';
    }
    return currentPasswordError;
  }

// Validate new password string and return an error message if invalid.
  String? validateNewPassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'New password is required.';
    }
    if (formPassword.length < 6) {
      return 'New password must be at least 6 characters long.';
    }
    return null;
  }

// Validate confirm password string and return an error message if invalid.
  String? validateConfirmPassword(
      String? formPassword, TextEditingController newPasswordController) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Confirm password is required.';
    }
    if (formPassword != newPasswordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
        key: _scaffoldMessengerKey,
        appBar: AppBar(title: const Text('Password Change')),
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
              "Update Password",
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
                      obscureText: passenable,
                      controller: currentPasswordController,
                      validator: validateCurrentPassword,
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
                        labelText: "current password",
                        hintText: "password",
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
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: passenable,
                      controller: newPasswordController,
                      validator: validateNewPassword,
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
                        labelText: "new password",
                        hintText: "password",
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
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: passenable,
                      controller: confirmPasswordController,
                      validator: (value) =>
                          validateConfirmPassword(value, newPasswordController),
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
                        labelText: "confirm password",
                        hintText: "password",
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
                      height: 15,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _changePassword();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                        child: const Text("Update Password"),
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
