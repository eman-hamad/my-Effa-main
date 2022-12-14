
import 'dart:convert';

import 'package:effah/modules/network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart'as Dio;
import 'package:flutter/material.dart';

UserInfooo welcomeFromJson(String str) => UserInfooo.fromJson(json.decode(str));

String welcomeToJson(UserInfooo data) => json.encode(data.toJson());

class UserInfooo {
  UserInfooo({
   this.user,
    this.images,
   this.questions,
   this.categories,
  });
 User? user;
 List<ImagesUser>? images;
  List<Questions>? questions;
  List<Categories>?categories;

  UserInfooo.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
    images = List.from(json['images']).map((e)=>ImagesUser.fromJson(e)).toList();
    questions = List.from(json['questions']).map((e)=>Questions.fromJson(e)).toList();
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user!.toJson();
    _data['images'] = images!.map((e)=>e.toJson()).toList();
    _data['questions'] = questions!.map((e)=>e.toJson()).toList();
    _data['categories'] = categories!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.frName,
    required this.lsName,
    this.FaName,
    this.idNumber,
    required this.image,
    required this.isLogin,
    required this.isComplet,
    required this.gender,
    required this.isBlock,
    required this.isWait,
    this.phoneCode,
    required this.phone,
    required this.countryId,
    required this.country,
    required this.isNew,
    this.govId,
    this.cityId,
    this.lastLoginAt,
    required this.religionId,
    required this.birthDate,
    required this.slug,
    this.identityFace,
    this.identityBack,
    this.passportImage,
    required this.isApproved,
    this.rejectResson,
    required this.aboutYou,
    required this.aboutPartner,
    required this.createdAt,
    required this.updatedAt,
    required this.age,
    required this.fullName,
  });
  late final int id;
  late final String frName;
  late final String lsName;
  late final Null FaName;
  late final Null idNumber;
  late final String image;
  late final int isLogin;
  late final int isComplet;
  late final int gender;
  late final int isBlock;
  late final int isWait;
  late final Null phoneCode;
  late final String phone;
  late final int countryId;
  late final String country;
  late final int isNew;
  late final Null govId;
  late final Null cityId;
  late final Null lastLoginAt;
  late final int religionId;
  late final String birthDate;
  late final String slug;
  late final Null identityFace;
  late final Null identityBack;
  late final Null passportImage;
  late final int isApproved;
  late final Null rejectResson;
  late final String aboutYou;
  late final String aboutPartner;
  late final String createdAt;
  late final String updatedAt;
  late final int age;
  late final String fullName;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    frName = json['frName'];
    lsName = json['lsName'];
    FaName = null;
    idNumber = null;
    image = json['image'];
    isLogin = json['is_login'];
    isComplet = json['is_complet'];
    gender = json['gender'];
    isBlock = json['is_block'];
    isWait = json['is_wait'];
    phoneCode = null;
    phone = json['phone'];
    countryId = json['country_id'];
    country = json['country'];
    isNew = json['is_new'];
    govId = null;
    cityId = null;
    lastLoginAt = null;
    religionId = json['religion_id'];
    birthDate = json['birth_date'];
    slug = json['slug'];
    identityFace = null;
    identityBack = null;
    passportImage = null;
    isApproved = json['is_approved'];
    rejectResson = null;
    aboutYou = json['about_you'];
    aboutPartner = json['about_partner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    age = json['age'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['frName'] = frName;
    _data['lsName'] = lsName;
    _data['FaName'] = FaName;
    _data['idNumber'] = idNumber;
    _data['image'] = image;
    _data['is_login'] = isLogin;
    _data['is_complet'] = isComplet;
    _data['gender'] = gender;
    _data['is_block'] = isBlock;
    _data['is_wait'] = isWait;
    _data['phone_Code'] = phoneCode;
    _data['phone'] = phone;
    _data['country_id'] = countryId;
    _data['country'] = country;
    _data['is_new'] = isNew;
    _data['gov_id'] = govId;
    _data['city_id'] = cityId;
    _data['lastLoginAt'] = lastLoginAt;
    _data['religion_id'] = religionId;
    _data['birth_date'] = birthDate;
    _data['slug'] = slug;
    _data['identity_face'] = identityFace;
    _data['identity_back'] = identityBack;
    _data['passport_image'] = passportImage;
    _data['is_approved'] = isApproved;
    _data['reject_resson'] = rejectResson;
    _data['about_you'] = aboutYou;
    _data['about_partner'] = aboutPartner;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['age'] = age;
    _data['full_name'] = fullName;
    return _data;
  }
}

class ImagesUser {
  ImagesUser({
    required this.id,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String image;
  late final int userId;
  late final String createdAt;
  late final String updatedAt;

  ImagesUser.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['user_id'] = userId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Questions {
  Questions({
    required this.id,
    required this.content,
    this.info,
    required this.isActive,
    required this.type,
    required this.gender,
    required this.order,
    required this.categoryId,
    this.ansId,
    this.quId,
    required this.level,
    required this.isSkipable,
    required this.regId,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnswer,
    this.answerContent,
    required this.answers,
  });
  late final int id;
  late final String content;
  late final Null info;
  late final int isActive;
  late final int type;
  late final int gender;
  late final int order;
  late final int categoryId;
  late final Null ansId;
  late final Null quId;
  late final int level;
  late final int isSkipable;
  late final int regId;
  late final String createdAt;
  late final String updatedAt;
  late final int isAnswer;
  late final Null answerContent;
  late final List<Answers> answers;

  Questions.fromJson(Map<String, dynamic> json){
    id = json['id'];
    content = json['content'];
    info = null;
    isActive = json['is_active'];
    type = json['type'];
    gender = json['gender'];
    order = json['order'];
    categoryId = json['category_id'];
    ansId = null;
    quId = null;
    level = json['level'];
    isSkipable = json['is_skipable'];
    regId = json['reg_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAnswer = json['is_answer'];
    answerContent = null;
    answers = List.from(json['answers']).map((e)=>Answers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['content'] = content;
    _data['info'] = info;
    _data['is_active'] = isActive;
    _data['type'] = type;
    _data['gender'] = gender;
    _data['order'] = order;
    _data['category_id'] = categoryId;
    _data['ans_id'] = ansId;
    _data['qu_id'] = quId;
    _data['level'] = level;
    _data['is_skipable'] = isSkipable;
    _data['reg_id'] = regId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['is_answer'] = isAnswer;
    _data['answer_content'] = answerContent;
    _data['answers'] = answers.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Answers {
  Answers({
    required this.id,
    required this.content,
    required this.deg,
    this.info,
    required this.isActive,
    required this.type,
    required this.quId,
    this.relatedQuId,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnswer,
  });
  late final int id;
  late final String content;
  late final int deg;
  late final Null info;
  late final int isActive;
  late final int type;
  late final int quId;
  late final Null relatedQuId;
  late final String createdAt;
  late final String updatedAt;
  late final int isAnswer;

  Answers.fromJson(Map<String, dynamic> json){
    id = json['id'];
    content = json['content'];
    deg = json['deg'];
    info = null;
    isActive = json['is_active'];
    type = json['type'];
    quId = json['qu_id'];
    relatedQuId = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAnswer = json['is_answer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['content'] = content;
    _data['deg'] = deg;
    _data['info'] = info;
    _data['is_active'] = isActive;
    _data['type'] = type;
    _data['qu_id'] = quId;
    _data['related_qu_id'] = relatedQuId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['is_answer'] = isAnswer;
    return _data;
  }
}

class Categories {
  Categories({
    required this.id,
    required this.name,
    this.info,
    required this.isActive,
    required this.reId,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
    required this.isFinish,
  });
  late final int id;
  late final String name;
  late final Null info;
  late final int isActive;
  late final int reId;
  late final String createdAt;
  late final String updatedAt;
  late final List<Questions> questions;
  late final int isFinish;

  Categories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    info = null;
    isActive = json['is_active'];
    reId = json['re_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questions = List.from(json['questions']).map((e)=>Questions.fromJson(e)).toList();
    isFinish = json['is_finish'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['info'] = info;
    _data['is_active'] = isActive;
    _data['re_id'] = reId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['questions'] = questions.map((e)=>e.toJson()).toList();
    _data['is_finish'] = isFinish;
    return _data;
  }
}
class USERDATA with ChangeNotifier {
  GetStorage storage = GetStorage();

  UserInfooo? user;

  Future <UserInfooo> fetchMembers1() async {
    try {
      Dio.Response response = await dio().post(
        'myData',
        data:Dio.FormData.fromMap({
          "user_id": storage.read('userId'),
        }),
      );
      user = UserInfooo.fromJson(response.data);
    } catch (err) {
      print(err);
      // ignore: unnecessary_brace_in_string_interps
    }
    notifyListeners();
    return user!;
  }

}
