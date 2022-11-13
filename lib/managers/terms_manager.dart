import 'dart:convert';

import 'package:effah/models/terms_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_constants.dart';

class TermsManager extends ChangeNotifier {
  Future<Terms> getTerms() async {
    final response = await http.get(Uri.parse(ApiConstants.termsEndpoint));

    if (response.statusCode == 200) {
      print(response.body);
      return Terms.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ');
    }
  }
}
