import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsModel extends ChangeNotifier {
  bool _darkMode;
  String _language;
  // Initialize the Firestore instance
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SettingsModel({
    required Map<String, dynamic> preferences,
  })  : _darkMode = preferences['darkMode'] ?? false,
        _language = preferences['language'] ?? 'en';

  // ... Other getters and setters

  bool get darkMode => _darkMode;

  void updateDarkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void updateLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  Future<void> saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _darkMode);
    prefs.setString('language', _language);
    notifyListeners();
    print("Saved Settings to preferences");
  }

  Future<void> saveToCloud() async {
    saveSettings();
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Save the settings to Firebase under the user's document
      await _firestore.collection('users').doc(userId).update({
        'darkMode': _darkMode,
        'language': _language,
      });
    } else {
      // Handle the case where there's no user logged in
      print("No user is logged in. Unable to save settings to Firebase.");
    }
  }

  Future<Map<String, dynamic>> getFromCloud() async {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Get the user's settings document from Firestore
    DocumentSnapshot settingsDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .collection('settings')
        .doc('user_settings')
        .get();

    // If the document doesn't exist, return an empty map
    if (!settingsDocument.exists) {
      return {};
    }

    // Convert the document data into a map and return it
    return settingsDocument.data() as Map<String, dynamic>;
  }

  void loadFromCloud() async {
    Map<String, dynamic> cloudSettings = await getFromCloud();
    if (cloudSettings != {}) {
      updateDarkMode(cloudSettings['darkMode'] ?? false); // Fixed the typo here
      updateLanguage(cloudSettings['language'] ?? 'en');
      saveSettings();
    }
  }
}
