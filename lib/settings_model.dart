import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  bool _darkMode;
  String _language;
  bool _loggedIn;

  SettingsModel({
    bool darkMode = false,
    String language = 'en',
    bool loggedIn = false,
  })  : _darkMode = darkMode,
        _language = language,
        _loggedIn = loggedIn;

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

  void updateLoggedIn(bool loggedIn) {
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
}
