class MyUser {
  int? id;
  String? frName;
  String? lsName;
  String? faName;
  String? idNumber;
  String? image;
  int? isLogin;
  String? isComplet;
  int? gender;
  String? isBlock;
  String? isWait;
  String? phoneCode;
  String? phone;
  int? countryId;
  String? country;
  int? isNew;
  String? govId;
  String? cityId;
  String? lastLoginAt;
  int? religionId;
  String? birthDate;
  String? createdAt;
  String? updatedAt;
  String? fullName;
  String? identity_face;
  String? identity_back;
  String? passport_image;
  String? about_you;
  String? about_partner;

  MyUser(
      {this.id,
      this.frName,
      this.lsName,
      this.faName,
      this.idNumber,
      this.image,
      this.isLogin,
      this.isComplet,
      this.gender,
      this.isBlock,
      this.isWait,
      this.phoneCode,
      this.phone,
      this.countryId,
      this.country,
      this.isNew,
      this.govId,
      this.cityId,
      this.lastLoginAt,
      this.religionId,
      this.birthDate,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.identity_back,
      this.identity_face,
      this.passport_image,
      this.about_you,
      this.about_partner});

  MyUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frName = json['frName'] != null ? json['frName'] : null;
    lsName = json['lsName'] != null ? json['lsName'] : null;
    faName = json['FaName'] != null ? json['FaName'] : null;
    // idNumber = json['idNumber'] != null ? json['idNumber'] :null;
    // image = json['image'] != null ? json['image'] :null;
    // isLogin = json['is_login'] != null ? json['is_login'] : null;
    // isComplet = json['is_complet'] != null ? json['is_complet'] :null;
    gender = json['gender'] != null ? json['gender'] : null;
    // isBlock = json['is_block'] != null ? json['is_block'] : null;
    // isWait = json['is_wait'] != null ? json['is_wait'] :null;
    phoneCode = json['phone_Code'] != null ? json['phone_Code'] : null;
    phone = json['phone'] != null ? json['phone'] : null;
    countryId = json['country_id'] != null ? json['country_id'] : null;
    country = json['country'] != null ? json['country'] : null;
    isNew =  json['is_new'] ;
    //isNew != null ? json['is_new'] : null;
    //!=null ? json['is_new']:null;
    // govId = json['gov_id'] != null ? json['gov_id'] :null;
    // cityId = json['city_id'] != null ? json['city_id'] :null;
    // lastLoginAt = json['lastLoginAt'] !=null ?json['lastLoginAt'] :null;
    religionId = json['religion_id'] != null ? json['religion_id'] : null;
    birthDate = json['birth_date'] != null ? json['birth_date'] : null;
    // createdAt = json['created_at'] !=null ? json['created_at'] : null;
    // updatedAt = json['updated_at'] !=null ? json['updated_at'] :null;
    // fullName = json['full_name'] !=null ? json['full_name'] : null;
    about_partner = json['about_partner'] != null ? json['about_partner'] : null;
    about_you = json['about_you'] != null ? json['about_you'] : null;
    identity_back =
        json['identity_back'] != null ? json['identity_back'] : null;
    identity_face =
        json['identity_face'] != null ? json['identity_face'] : null;
    passport_image =
        json['passport_image'] != null ? json['passport_image'] : null;
  }

  static Map<String, dynamic> toJson(MyUser userModel) {
    return {
      'id': userModel.id,
      'frName': userModel.frName,
      'lsName': userModel.lsName,
      'FaName': userModel.faName,
      'idNumber': userModel.idNumber,
      'image': userModel.image,
      'is_login': userModel.isLogin,
      'is_complet': userModel.isComplet,
      'gender': userModel.gender,
      'is_block': userModel.isBlock,
      'is_wait': userModel.isWait,
      'phone_Code': userModel.phoneCode,
      'phone': userModel.phone,
      'country_id': userModel.countryId,
      'country': userModel.country,
      'is_new': userModel.isNew,
      'gov_id': userModel.govId,
      'city_id': userModel.cityId,
      'lastLoginAt': userModel.lastLoginAt,
      'religion_id': userModel.religionId,
      'birth_date': userModel.birthDate,
      'created_at': userModel.createdAt,
      'updated_at': userModel.updatedAt,
      'full_name': userModel.fullName,
      'identity_back': userModel.identity_back,
      'identity_face': userModel.identity_face,
      'passport_image': userModel.passport_image,
      'about_partner' : userModel.about_partner,
      'about_you':userModel.about_you
    };
  }
}
