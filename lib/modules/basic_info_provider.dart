import 'dart:io';

import 'package:flutter/material.dart';

import '../managers/question_manager.dart';

class InfoProvider with ChangeNotifier {
  int myIndexPersonal = 0;
  int myIndexScoial = 0;
  int myIndexFamily = 0;
  int myIndexEducation = 0;
  int myIndexParent = 0;
  // bool isMale = false;
  bool isFemale = false;
  bool loading = false;

  double progressValue = 0.25;

  double religionProgressValue = 0.0;
  double personalProgressValue = 0.0;
  double familyProgressValue = 0.0;
  double educationProgressValue = 0.0;
  double parentProgressValue = 0.0;

  bool press = false;
  bool pressed1 = false;
  bool pressed2 = false;
  bool pressedPic = false;
  File imagePic = File("");

  increment(int v) {
    if (v < 2) {
      v++;
      notifyListeners();
    }
  }

  void rebuild() {
    notifyListeners();
  }

  void rebuild2() {
    press = !press;
    notifyListeners();
  }
}
