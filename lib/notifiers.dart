import 'package:flutter/material.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

class ModelHolder extends ChangeNotifier {
  FirebaseCustomModel? _model;

  FirebaseCustomModel? get model => _model;

  set model(FirebaseCustomModel? newModel) {
    _model = newModel;
    notifyListeners();
  }
}

class PageNotifier extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
