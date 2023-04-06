import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool passenable = true;

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
        // Navigate to the login page
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (r) => false,
        );
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
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //**top part**
              Image(image: AssetImage('assets/images/logo1.png')),
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.black,
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
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                                borderRadius: BorderRadius.circular(40.0),
                                ),
                              focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              prefixIcon: Icon(Icons.person_outline_outlined),
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
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          prefixIcon: Icon(Icons.mail),
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
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          prefixIcon: Icon(Icons.phone),
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
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          labelText: "Password",
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon (
                                passenable ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                passenable = !passenable;
                              });
                            },
                          ),
                          alignLabelWithHint: false,
                          filled: true,
                          fillColor: Colors.white,
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
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5,
                                color: Color.fromARGB(223, 212, 89, 100)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          labelText: "Confirm Password",
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                            icon: Icon (
                                passenable ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                passenable = !passenable;
                              });
                            },
                          ),
                          alignLabelWithHint: false,
                          filled: true,
                          fillColor: Colors.white,
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
                          child: Text("SIGN UP"),
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
                          child: const Text.rich(
                            TextSpan(
                                text: "Already have an account?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0),
                                children: const [
                                  TextSpan(
                                    text: " Login",
                                    style: TextStyle(color: Color.fromARGB(223, 212, 89, 100)),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      ],
                    ),
                   )
                  )
           ]),
        ),
      ),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    // Get the screen size.

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/lego.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3,
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  //Register form
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
                                hintText: " Email",
                                prefixIcon: const Icon(Icons.email_outlined,
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
                            controller: phoneController,
                            validator: validatePhone,
                            decoration: InputDecoration(
                                hintText: "Phone",
                                prefixIcon: const Icon(Icons.phone,
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
                            controller: nameController,
                            validator: validateName,
                            decoration: InputDecoration(
                                hintText: "Full Name",
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
                                prefixIcon: const Icon(Icons.lock,
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
                            controller: confirmationController,
                            validator: validateConfirmation,
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon: const Icon(Icons.lock,
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
                      if (_key.currentState!.validate()) {
                        _register();
                      }
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
}*/

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
  // Return null if input is not null or empty.
  return null;
}

String? validateConfirmation(String? formConfirmation) {
  if (formConfirmation == null || formConfirmation.isEmpty) {
    return 'Please confirm your password';
  }
  //other validations go here
  return null;
}
