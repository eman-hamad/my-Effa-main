import 'package:dio/dio.dart';
Dio dio() {
  Dio dio = Dio();
  dio.options.baseUrl = "https://elshakhs.net/effah/public/api/";
  dio.options.headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  return dio;
}
