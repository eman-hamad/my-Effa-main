import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_constants.dart';
import '../models/images_model.dart';
import '../models/user_model.dart';
import '../models/user_upload_images_model.dart';

class UserManager extends ChangeNotifier {
  late Dio dio;

  UserManager() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: 1000 * 60 * 2,
        receiveTimeout: 1000 * 60 * 2,
        receiveDataWhenStatusError: true,
        contentType: "application/json",
        headers: {'Content-Type': 'application/json'});
    dio = Dio(baseOptions);
  }
  Future<MyUser> postUser(
      String? phone, String? phone_code, String? country) async {
    final response = await http.post(
      Uri.parse(ApiConstants.userEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'phone': phone!,
        'phone_code': phone_code!,
        'country': country!
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);

      notifyListeners();
      return MyUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed .');
    }
  }

  Future<MyUser> updateUser(int? user_id,
      {int? gender,
      String? frName,
      String? lsName,
      String? birth_date,
      String? country_id,
      String? religion_id,
      String? about_you,
      String? about_partner}) async {
    final response = await http.post(
      Uri.parse(ApiConstants.updatProfileEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': user_id,
        'gender': gender,
        'frName': frName,
        'lsName': lsName,
        'birth_date': birth_date,
        'country_id': country_id,
        'religion_id': religion_id,
        'about_partner': about_partner,
        'about_you': about_you
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      notifyListeners();
      return MyUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed ');
    }
  }

Future<MyUser> confirmInfo(UserImages userImages,int? id,) async {
  var fields = FormData.fromMap({});
  try {
    fields = FormData.fromMap({
      'user_id': id,
      if(userImages.image1.path.isNotEmpty)
      'identity_face': await MultipartFile.fromFile(userImages.image1.path),
      if(userImages.image2.path.isNotEmpty)
      'identity_back': await MultipartFile.fromFile(userImages.image2.path),
      if(userImages.image3.path.isNotEmpty)
      'passport_image': await MultipartFile.fromFile(userImages.image3.path),


    });

  Response response = await dio.post('user_images', data: fields);
  return MyUser.fromJson(response.data);
}  on DioError catch (e) {

//final errorMessage = DioExceptions.fromDioError(e).toString();
print('Error=>${e.message}');
return MyUser();

}}
  Future<MyUser> uploadImages(List<File> files,int? id,) async {
    var fields = FormData.fromMap({});
    List<MultipartFile> multiparts=[];
for(int i=0;i<files.length;i++){
  if(files.elementAt(i).path.isNotEmpty) {
    multiparts.add(await MultipartFile.fromFile(files[i].path));
  }
}
    try {
      fields = FormData.fromMap({
        'user_id': id,
          'images[]': multiparts,


      });

      Response response = await dio.post('user_imagesmale', data: fields);
      print("ssssss${response.statusCode}");
      return MyUser.fromJson(response.data);
    }  on DioError catch (e) {

//final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${e.message}');
      return MyUser();

    }}
  Future<List<Images>> getImages(int id) async {
    final response = await http.post(Uri.parse(ApiConstants.imagesEndPoint),

      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, dynamic>{
      "user_id":id
      }),

      );

    if (response.statusCode == 200) {
      print("jjjjjj${response.body}");
      final responsebody=jsonDecode(response.body) as List;
      final allImagesList= responsebody.map((e) => Images.fromJson(e)).toList();

      return allImagesList;
    } else {
      print("hhhhh${response.statusCode}");
      throw Exception('Failed to load ');
    }
  }
}