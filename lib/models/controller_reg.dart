import 'package:effah/pages/basic_info/options/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../managers/user_manager.dart';
import 'user_model.dart';

class ControllerReg extends ChangeNotifier {
  static int? gender;
  static String? fname;
  static String? lname;

  static String? birth;
  static int? nationaityID;

  PageController pageController = PageController(initialPage: 0);
  double position = 0.15;
  int? selectedChoise;
  int? index;
  void changeIndex(int i){
    selectedChoise  = i;
    notifyListeners();
  }
  void listPosition(int i){
    index  = i;
    notifyListeners();
  }
  void changeIndexn(){
    selectedChoise  = null;
    notifyListeners();
  }
  void onTap(
    value,
  ) {
    pageController.nextPage(
        duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
    position = value;
    notifyListeners();
  }

  void finalTap(BuildContext ctx, int religionID, int id) async {
    position = 1.0;
    print(" ControllerReg.gender");
    print(ControllerReg.gender);
    final MyUser user = await UserManager().updateUser(id,
        religion_id: religionID,
        gender: ControllerReg.gender,
        frName: ControllerReg.fname,
        lsName: ControllerReg.lname,
        birth_date: ControllerReg.birth,
        country_id: ControllerReg.nationaityID);
      
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (context) => Options( id: id, gender: ControllerReg.gender! , 
            isComplete:  user.isComplet,)));
    notifyListeners();
  }


  void back(){
    position = position-0.15;
    pageController.previousPage(duration: Duration(milliseconds: 250), curve:Curves.fastOutSlowIn);
    notifyListeners();
  }
}
