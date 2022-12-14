import 'dart:io';
import 'package:dio/dio.dart'as Dio;
import 'package:effah/modules/network.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
class Posts with ChangeNotifier{
  GetStorage storage = GetStorage();
  bool isImageUploaded =false;
  Future<bool> updateImg(File userImg,BuildContext ctx) async {
    var imageServer;
    if (userImg != null) {
      imageServer = await Dio.MultipartFile.fromFileSync(
        userImg.path,
        filename: userImg.path
            .split('/')
            .last,
      );
    }
    Map<String,dynamic> api ={
      "user_id": storage.read('userId'),
    };
    try {
      Dio.Response response = await dio().post(
        'update_profile_image',
        data: Dio.FormData.fromMap(api),
      );
      print(response.data);

      notifyListeners();
      return isImageUploaded;
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  bool isImgsList =false;
  Future<bool> updateImgs(List<File> userImgs,BuildContext ctx) async {
    Map<String,dynamic> api ={
      "user_id": storage.read('userId'),
    };
    for (int i = 0;i<userImgs.length; i++){
      api['images[$i]'] = await Dio.MultipartFile.fromFile(userImgs[i].path,
          filename: userImgs[i].path);
    }
    try {
      Dio.Response response = await dio().post(
        'user_imagesmale',
        data: Dio.FormData.fromMap(api),
      );
      print(response.data);

      notifyListeners();
      return isImageUploaded;
    } catch (error) {
      print(error);
      throw (error);
    }
  }

}
class HttpExeption implements Exception {
  final String message;

  HttpExeption(this.message);

  @override
  String toString() {
    return message;
  }
}