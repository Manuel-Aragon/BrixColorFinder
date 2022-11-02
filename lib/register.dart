import 'package:flutter/material.dart';
import 'package:lucky13capstone/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Register")),
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
                      boxShadow: [
                        const BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0,10)
                        )
                      ]
                  ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: " Email",
                                prefixIcon: Icon(Icons.email_outlined, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Phone",
                                prefixIcon: Icon(Icons.phone, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Full Name",
                                prefixIcon: Icon(Icons.person, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
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
                        // Navigator.push(
                        // context,
                        // MaterialPageRoute(builder: (context) => SignUpPage()),
                        // );
                      },
                    style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent),
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