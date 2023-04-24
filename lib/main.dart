import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // used to work with ChangeNotifiers, Consumers, and Producers to manage State
import 'package:lucky13capstone/history_page.dart'; // used to access the HistoryModel for updating the State of the Scan History
import 'package:lucky13capstone/classifier/lego_recognizer.dart';
import 'package:shared_preferences/shared_preferences.dart'; //used to save and restore settings when app is launched
import 'settings_model.dart';
import 'package:lucky13capstone/themes.dart';
import 'package:lucky13capstone/landing_page.dart';
import 'package:lucky13capstone/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initialize firebase

  // Load Preferences
  Map<String, dynamic> preferences = await loadPreferences();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HistoryModel()),
        ChangeNotifierProvider(
          create: (context) => SettingsModel(preferences: preferences),
        ),
      ],
      child: const BrickFinder(),
    ),
  );
  // runApp(const BrickFinder());   // this is the original way we called this without Provider class
}

class BrickFinder extends StatelessWidget {
  const BrickFinder({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    // Choose the theme based on the darkMode setting
    final theme = settings.darkMode ? darkTheme : lightTheme;

    return MaterialApp(
      theme: theme,
      home: const BottomNav(),
      //home: const LandingPage(),
    );
  }
}

// This class was created as our main widget, which contains our bottom navigation bar
class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNav();
}

// This class creates a widget that includes the bottom navigation bar of the app,
// as well as the body of other pages (screens), based on what bottom navigation bar index
// is currently selected (currentIndex).
class _BottomNav extends State<BottomNav> {
  int currentIndex = 0;
  final screens = [LegoRecogniser(), HistoryPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined), label: 'Scan'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_sharp), label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
      );
}

Future<Map<String, dynamic>> loadPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Return the preferences in a map
  return {
    'darkMode': prefs.getBool('darkMode') ?? false,
    'language': prefs.getString('language') ?? 'en',
    'loggedIn': prefs.getBool('loggedIn') ?? false,
  };
}
