import 'package:effah/models/question_model.dart';
import 'package:effah/models/question_model.dart';

class Questions {
  //Question? questions;
  List<Question>? questions;
  int? is_finish;
  Questions({this.questions,required this.is_finish});

  factory Questions.fromJson(Map<String, dynamic> json) {
    // questions = Question.fromJson(json['questions']);
    //  var tagObjsJson = json['questions'] as List;
    //   List<Question> _tags =
    //       tagObjsJson.map((tagJson) => Question.fromJson(tagJson)).toList();
    return Questions(
      is_finish :json['is_finish'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();

  //   data['is_finish'] = this.is_finish;
  //   return data;
  // }
}
