import 'package:effah/pages/basic_info/options/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ControllerReg extends ChangeNotifier{
  PageController pageController = PageController(initialPage: 0);
  double position = 0.15;
  void onTap(value){
    pageController.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.bounceInOut);
    position=value;
    notifyListeners();
  }
  void finalTap (BuildContext ctx){
    position = 1.0;
    Navigator.push(ctx,  MaterialPageRoute(builder: (context) => const Options(progress: progress, id: id, gender: gender)));
    notifyListeners();
  }
}