import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:lucky13capstone/scan_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initialize firebase
  //cameras = await availableCameras();
  runApp(const BrickFinder());
}

class BrickFinder extends StatelessWidget {
  const BrickFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        scaffoldBackgroundColor: const Color(0xFfffffff),
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(255, 38, 214, 226)),
        listTileTheme: const ListTileThemeData(
            textColor: Color.fromARGB(255, 25, 39, 48),
            iconColor: Color.fromARGB(255, 25, 39, 48)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color.fromARGB(
                223, 212, 89, 100), // background (button) color
            foregroundColor: const Color(0xFfffffff), // foreground (text) color
          ),
        ),
      ),
      dark: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 25, 39, 48),
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(223, 212, 89, 100)),
        listTileTheme: const ListTileThemeData(
            textColor: Color.fromARGB(255, 38, 214, 226),
            iconColor: Color.fromARGB(255, 38, 214, 226)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color.fromARGB(
                255, 38, 214, 226), // background (button) color
            foregroundColor: const Color.fromARGB(
                255, 25, 39, 48), // foreground (text) color
          ),
        ),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
          theme: theme, darkTheme: darkTheme, home: const DevPage(title: 'Dev Page')),
    );
  }
}

//List<CameraDescription> cameras;
