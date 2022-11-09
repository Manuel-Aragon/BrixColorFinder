import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
              Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (r) => false);
      }
    });
    } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      if (kDebugMode) {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
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
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Register")),
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
                          fit: BoxFit.fill
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 300),
                  child: const Center(
                    child: Text("Register", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
                  )
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container( //login form
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0,10)
                        )
                      ]
                  ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: " Email",
                                prefixIcon: const Icon(Icons.email_outlined, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Phone",
                                prefixIcon: const Icon(Icons.phone, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Full Name",
                                prefixIcon: const Icon(Icons.person, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        )
                      ],
                    ),
                ),
                const SizedBox(height: 10),
                Container(  //registration button
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(16, 20, 251, 1),
                          Color.fromRGBO(16, 20, 251, .6),
                        ]
                    )
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _register();
                        // Navigator.push(
                        // context,
                        // MaterialPageRoute(builder: (context) => SignUpPage()),
                        // );
                      },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                    child: const Center(
                      child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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