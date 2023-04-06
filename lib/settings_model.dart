import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsModel extends ChangeNotifier {
  bool _darkMode;
  String _language;
  bool _loggedIn;
  // Initialize the Firestore instance
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SettingsModel({
    required Map<String, dynamic> preferences,
  })  : _darkMode = preferences['darkMode'] ?? false,
        _language = preferences['language'] ?? 'en',
        _loggedIn = preferences['loggedIn'] ?? false;

  // ... Other getters and setters

  bool get darkMode => _darkMode;
  bool get loggedIn => _loggedIn;

  void updateDarkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void updateLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  void updateLoggedIn(bool loggedIn) {
    print("test");
    print(_loggedIn);
    print(loggedIn);
    _loggedIn = loggedIn;
    notifyListeners();
  }

  Future<void> saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _darkMode);
    prefs.setString('language', _language);
    prefs.setBool('loggedIn', _loggedIn);
    notifyListeners();
    print("Saved Settings to preferences");
  }

  Future<void> saveToCloud() async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Save the settings to Firebase under the user's document
      await _firestore.collection('users').doc(userId).update({
        'darkMode': _darkMode,
        'language': _language,
        'loggedIn': _loggedIn,
      });
    } else {
      // Handle the case where there's no user logged in
      print("No user is logged in. Unable to save settings to Firebase.");
    }
  }
}
