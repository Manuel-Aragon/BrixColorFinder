import 'package:flutter/material.dart';
import 'package:lucky13capstone/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucky13capstone/temp_scan.dart';

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

// This method is called by the _login method to start the authentication process.
  void _authenticate() async {
    try {
      // Call the signInWithEmailAndPassword method to authenticate the user.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } catch (error) {
      print(error);
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
        //pushAndRemoveUntil() used so that user can't navigate back after they login
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ScanPage()),
            (r) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 370,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/lego.png'),
                          fit: BoxFit.fill)),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 300),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
            Column(
              children: [
                Container(
                  //login form
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade100))),
                          child: TextFormField(
                            controller: emailController,
                            validator: validateEmail,
                            decoration: InputDecoration(
                                hintText: " Email or Phone number",
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade100))),
                          child: TextFormField(
                            controller: passwordController,
                            validator: validatePassword,
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock_outline,
                                    color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  //login button
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(16, 20, 251, 1),
                        Color.fromRGBO(16, 20, 251, .6),
                      ])),
                  child: ElevatedButton(
                    onPressed: () async {
                      _login();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  //registration button
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(16, 20, 251, 1),
                        Color.fromRGBO(16, 20, 251, .6),
                      ])),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// This code is validating the input of an email address and password.
//If either the email address or password is empty, a message is returned to the user. Otherwise, null is returned.
String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'E-mail address is required.';
  }
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }
  return null;
}
