class Question {
  int? id;
  String? content;
  String? info;
  int? isActive;
  int? type;
  int? gender;
  int? order;
  int? categoryId;
  int? ansId;
  int? quId;
  int? level;
  String? createdAt;
  String? updatedAt;
  List<Answers>? answers;

  Question(
      {this.id,
      this.content,
      this.info,
      this.isActive,
      this.type,
      this.gender,
      this.order,
      this.categoryId,
      this.ansId,
      this.quId,
      this.level,
      this.createdAt,
      this.updatedAt,
      this.answers});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    info = json['info'];
    isActive = json['is_active'];
    type = json['type'];
    gender = json['gender'];
    order = json['order'];
    categoryId = json['category_id'];
    ansId = json['ans_id'];
    quId = json['qu_id'];
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['info'] = this.info;
    data['is_active'] = this.isActive;
    data['type'] = this.type;
    data['gender'] = this.gender;
    data['order'] = this.order;
    data['category_id'] = this.categoryId;
    data['ans_id'] = this.ansId;
    data['qu_id'] = this.quId;
    data['level'] = this.level;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? id;
  String? content;
  int? deg;
  Null? info;
  int? isActive;
  int? type;
  int? quId;
  String? createdAt;
  String? updatedAt;
  int? isAnswer;
  int? related_qu_id;

  Answers(
      {this.id,
      this.content,
      this.deg,
      this.info,
      this.isActive,
      this.type,
      this.quId,
      this.createdAt,
      this.updatedAt,
      this.isAnswer,
      this.related_qu_id});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    deg = json['deg'];
    info = json['info'];
    isActive = json['is_active'];
    type = json['type'];
    quId = json['qu_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAnswer = json['is_answer'];
    related_qu_id = json['related_qu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['deg'] = this.deg;
    data['info'] = this.info;
    data['is_active'] = this.isActive;
    data['type'] = this.type;
    data['qu_id'] = this.quId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_answer'] = this.isAnswer;
    data['related_qu_id'] = this.related_qu_id;
    return data;
  }
}
