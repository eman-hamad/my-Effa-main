import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart'as Dio;
import 'package:effah/constants.dart';

import 'package:effah/models/questions_model.dart';
import 'package:effah/modules/network.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../api_constants.dart';
import '../models/question_model.dart';

class QuestionManager extends ChangeNotifier {
  static int len = 0;
  GetStorage storage = GetStorage();
  Future<List<Question>> getQuestions(int category_id, int level, BuildContext ctx) async {
    var map;
    final response = await http.get(
      Uri.parse("${ApiConstants.questionEendPoint2}/$category_id/${storage.read('userId')}/$level"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    try{
      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);
        map = responsebody["questions"].map<Question>((json) => Question.fromJson(json));

        len = map.toList().length;
        if(len==0){
          Navigator.pop(ctx);
          ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
            backgroundColor: basicPink,
            content: Directionality(
                textDirection: TextDirection.rtl,
                child: Text("تم ارسال البيانات")),
          ));
        }

      } else {
        throw Exception('Failed to load ');
      }
    }catch(e){
    }
    return map.toList();
  }

  Future <Questions> isCategoryFinished(
      int user_id, int category_id, int gender) async {
        try{
    final response = await http.post(
      Uri.parse(ApiConstants.questionEendPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': user_id,
        'category_id': category_id,
        'gender': gender
      }),
    );

    if (response.statusCode == 200) {
      print("response.body");
      print(response.body);

      print(Questions.fromJson(jsonDecode(response.body)));
      return Questions.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ');
    }
      }
    catch (e) {
      print(e.toString());
      throw Exception(e.toString());
  // TODO: handle exception, for example by showing an alert to the user
}
  }

  Future<void> postAnswer(
    int que_id, {
    List<dynamic>? len,
    int? one_choice,
    int? index,
    List<int>? multiple_choice,
    String? text,
  }) async {
    GetStorage userId = GetStorage();
    // print("response.body");
    List<int> list = [];
    final response = await http.post(
      Uri.parse(ApiConstants.answerEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId.read("userId"),
        'que_id': que_id,
        'one_choice': one_choice,
        // 'multiple_choice'[0]: 27,
        //for (var i in len!)

        'multiple_choice': multiple_choice,
        'text': text,
      }),
    );
    print(response.body);
    print(userId.read("userId"));
    if (response.statusCode == 200) {
      final responsebody = jsonDecode(response.body);
      print("answer");

      print(responsebody);
    } else {
      throw Exception('Failed to load ');
    }
  }
  Future<void> postAnswer2(
      int que_id, {
        List<int>? multiple_choice,
      }) async {
    GetStorage userId = GetStorage();
    Map<String, dynamic> api ={
      'user_id': userId.read("userId"),
      'que_id': que_id,
    };
    for(int i = 0;i<multiple_choice!.length; i++){
      api['multiple_choice[$i]'] = multiple_choice[i];
    }
    print(api);
    print(jsonEncode(api));
    Dio.Response response = await dio().post(
      'questions/answer',
      data: Dio.FormData.fromMap(api),
    );
    print(response.data);
    if (response.statusCode == 200) {

    } else {
      throw Exception('Failed to load ');
    }
  }
  Future<void> postAnswer3(
      int que_id, {
        String? text,
      }) async {
    GetStorage userId = GetStorage();
    Map<String, dynamic> api ={
      'user_id': userId.read("userId"),
      'que_id': que_id,
      'text': text,
    };

    Dio.Response response = await dio().post(
      'questions/answer',
      data: Dio.FormData.fromMap(api),
    );
    print(response.data);
    if (response.statusCode == 200) {

    } else {
      throw Exception('Failed to load ');
    }
  }
  Future<Question> getQuestion(
      int user_id, int category_id, int gender, int question_id) async {
    final response = await http.post(
      Uri.parse(ApiConstants.oneQuestionEendPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': user_id,
        'category_id': category_id,
        'gender': gender,
        'question_id': question_id
      }),
    );

    if (response.statusCode == 200) {
      print("lllll");

      print(response.body);

      return Question.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ');
    }
  }
}
