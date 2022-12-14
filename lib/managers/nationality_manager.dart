import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_constants.dart';
import '../models/nationality_model.dart';

class NationalityManager extends ChangeNotifier {
  Future<List<Nationality>> getNationality() async {

    final response = await http
        .get(Uri.parse('https://elshakhs.net/effah/public/api/general/nationality'));

    if (response.statusCode == 200) {
      final responsebody = jsonDecode(response.body) as List;

      final nationalityList = responsebody.map((e) => Nationality.fromJson(e)).toList();
      print(response.body);
      return nationalityList;
    } else {
      print(response.body);
      throw Exception('Failed to load ');
    }
  }
}
