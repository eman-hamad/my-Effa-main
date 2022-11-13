import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;


  Future<void> setUser(MyUser userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user', jsonEncode(MyUser.toJson(userModel)));
  }

  Future<MyUser> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    MyUser userModel;
 //   print("Ddlldl${jsonData}");
    if (jsonData != null) {
      userModel = MyUser.fromJson(jsonDecode(jsonData));
      userModel.isLogin = 1;
    }else{
      userModel = MyUser();

      userModel.isLogin = 0;

    }

    return userModel;
  }

  clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
