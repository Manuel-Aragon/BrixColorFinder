import 'package:flutter/material.dart';
import 'package:lucky13capstone/register.dart';
import 'package:lucky13capstone/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _authenticate() async {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
  );
  }


  void _login() {
    if (_key.currentState!.validate()){
      _authenticate();
    }
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
            Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TakePictureScreen()),
      (r) => false);
    }
  });
  }


  @override

  Widget build(BuildContext context){  
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
                          fit: BoxFit.fill
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 300),
                  child: const Center(
                    child: Text("Login", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
                  )
                )
              ],
            ),
            Column(
              children: [
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
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextFormField(
                            controller: emailController, 
                            validator: validateEmail,
                            decoration: InputDecoration(
                                hintText: " Email or Phone number",
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
                          child: TextFormField(
                            controller: passwordController,
                            validator: validatePassword,
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock_outline, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(  //login button
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
                    onPressed: () async{
                      _login();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                    child: const Center(
                      child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
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
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
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

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty){
    return 'E-mail address is required.';
  }
  //
  return null;
}
String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty){
    return 'Password is required.';
  }
  return null;
}