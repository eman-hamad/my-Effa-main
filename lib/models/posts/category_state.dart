import 'dart:convert';

import 'package:effah/modules/network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart'as Dio;
import 'package:flutter/material.dart';

CategoryState welcomeFromJson(String str) => CategoryState.fromJson(json.decode(str));

String welcomeToJson(CategoryState data) => json.encode(data.toJson());
class CategoryState {
  CategoryState({
    required this.categryOne,
    required this.categoryTwo,
    required this.categoryThree,
    required this.categoryFour,
    required this.categoryFive,
  });
  late final int categryOne;
  late final int categoryTwo;
  late final int categoryThree;
  late final int categoryFour;
  late final int categoryFive;

  CategoryState.fromJson(Map<String, dynamic> json){
    categryOne = json['categryOne'];
    categoryTwo = json['categoryTwo'];
    categoryThree = json['categoryThree'];
    categoryFour = json['categoryFour'];
    categoryFive = json['categoryFive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categryOne'] = categryOne;
    _data['categoryTwo'] = categoryTwo;
    _data['categoryThree'] = categoryThree;
    _data['categoryFour'] = categoryFour;
    _data['categoryFive'] = categoryFive;
    return _data;
  }
}
class CategoryProvider with ChangeNotifier {
  GetStorage storage = GetStorage();

  CategoryState? state;

  Future <CategoryState> fetchCategoryState() async {
    try {
      Dio.Response response = await dio().get(
        'myData',
      );
      state = CategoryState.fromJson(response.data);
    } catch (err) {
      print(err);
      // ignore: unnecessary_brace_in_string_interps
    }
    notifyListeners();
    return state!;
  }

}