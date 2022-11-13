class Images {
  int? id;
  String? image;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  static Map<String, dynamic> toJson(Images images) {
    return {
      'id' : images.id,
      'image' : images.image,
    };
  }

}
