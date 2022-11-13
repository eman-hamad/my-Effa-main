class Nationality {
  int? id;
  String? name;
  String? fName;
  String? info;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Nationality(
      {this.id,
      this.name,
      this.fName,
      this.info,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Nationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fName = json['fName'];
    info = json['info'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fName'] = this.fName;
    data['info'] = this.info;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
