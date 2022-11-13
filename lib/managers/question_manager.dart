import 'dart:convert';

import 'package:effah/models/questions_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_constants.dart';
import '../models/question_model.dart';

class QuestionManager extends ChangeNotifier {
  static int len = 0;
  Future<List<Question>> getQuestions(
      int user_id, int category_id, int gender) async {
    // len = 0;
    // print("response.body");
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
      print("apiiiiiiiiiiiiiiiiiiiiiiiii");

      print(response.body);

      final responsebody = jsonDecode(response.body);

      var map = responsebody["questions"]
          .map<Question>((json) => Question.fromJson(json));
// if( responsebody.)
      len = map.toList().length;
      print("map.toList().length");
      print(len);
      return map.toList();
      // return Questions.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ');
    }
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
    int user_id,
    int que_id, {
    List<dynamic>? len,
    int? one_choice,
    int? index,
    List<int>? multiple_choice,
    String? text,
  }) async {
    // print("response.body");
    List<int> list = [];
    final response = await http.post(
      Uri.parse(ApiConstants.answerEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': user_id,
        'que_id': que_id,
        'one_choice': one_choice,
        // 'multiple_choice'[0]: 27,
        //for (var i in len!)

        'multiple_choice': multiple_choice,
        'text': text,
      }),
    );

    if (response.statusCode == 200) {
      final responsebody = jsonDecode(response.body);
      print("answer");

      print(responsebody);
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
