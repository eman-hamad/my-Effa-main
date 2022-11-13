import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_constants.dart';
import '../models/nationality_model.dart';

class NationalityManager extends ChangeNotifier {
  Future<List<Nationality>> getNationality() async {
    print("response.body");
    final response = await http
        .get(Uri.parse('http://motakam.motakamel.net/api/general/nationality'));

    if (response.statusCode == 200) {
      final responsebody = jsonDecode(response.body) as List;

      final nationalityList =
          responsebody.map((e) => Nationality.fromJson(e)).toList();

      return nationalityList;
    } else {
      throw Exception('Failed to load ');
    }
  }
}
