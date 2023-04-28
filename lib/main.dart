import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_model.dart';
import 'themes.dart';
import 'settings_page.dart';
import 'history_page.dart';
import 'classifier/lego_recognizer.dart';
import 'notifiers.dart';

const kModelName = "brick_model_unquant";

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
        ChangeNotifierProvider(create: (context) => PageNotifier()),
      ],
      child: const BrickFinder(),
    ),
  );
}

class BrickFinder extends StatefulWidget {
  const BrickFinder({Key? key}) : super(key: key);

  @override
  _BrickFinderState createState() => _BrickFinderState();
}

class _BrickFinderState extends State<BrickFinder> {
  // Declare screens as a late variable so it can be initialized in initState
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();

    // Initialize the screens list here and pass the model
    screens = [
      const LegoRecogniser(), // Use widget.model here
      const HistoryPage(),
      const SettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    // Choose the theme based on the darkMode setting
    final theme = settings.darkMode ? darkTheme : lightTheme;

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: screens[context.watch<PageNotifier>().currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<PageNotifier>().currentIndex,
          onTap: (index) => context.read<PageNotifier>().setCurrentIndex(index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined), label: 'Scan'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_sharp), label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
      ),
    );
  }
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
