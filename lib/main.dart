import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lucky13capstone/register.dart';
import 'package:lucky13capstone/login.dart';



void main() async {
    WidgetsFlutterBinding.ensureInitialized(); 
    await Firebase.initializeApp(); 
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Home Page'),
      ) //MaterialApp
    ); 
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    void _onItemTapped(int index) {
    setState(() {

      _selectedIndex = index;

    });
    _navigate(index);
    }

    void _navigate(int  index) {
      switch(index) { 
        case 0: { 
                    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
                );
        } 
        break; 
        
        case 1: { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                );
        } 
        break;
        case 2: {
                        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
                );
        } 
      } 
    }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Test Navigation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Register',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class SecondScreen extends StatelessWidget{
  const SecondScreen({ Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Navigation Test')),
      body: Center(
        ),  //center
      bottomNavigationBar: BottomAppBar(  //nav bar to hold return button
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child : ElevatedButton( //return button
            child: Text('Go back to home screen'),
            onPressed: () {
                Navigator.pop(context);
            },
          ),  //elevated button
          ),//container
        ),//bottonNavigationBar
      );  //scaffold
  }
}