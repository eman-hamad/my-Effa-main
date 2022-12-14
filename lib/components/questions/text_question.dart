import 'package:effah/constants.dart';
import 'package:effah/models/controller_reg.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../modules/basic_info_provider.dart';
import '../../managers/question_manager.dart';
import '../../models/question_model.dart';

class TextQuestion extends StatefulWidget {
  TextQuestion(
      {Key? key,
        required this.question,
      required this.id,
        this.answers,
        this.Q_id,
      })
      : super(key: key);
  String question;
  int? id;
  int? Q_id;
  List<Answers>? answers;
  @override
  State<TextQuestion> createState() => _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestion> {
  TextEditingController txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref =
    Provider.of<ControllerReg>(context, listen: false);
    return Column(
      children: [
        Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                widget.question,
                style: TextStyle(fontSize: 20.sp),
              ),
            )),
        Padding(
          padding:
          EdgeInsets.only(right: 15.w, left: 15.w, top: 10.h),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              cursorColor: basicPink,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 20.h, horizontal: 15.w),
                hintStyle: TextStyle(fontSize: 14.sp),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: grey, width: 2.w),
                  borderRadius:
                  BorderRadius.all(Radius.circular(15.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: basicPink, width: 1.5.w),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusColor: basicPink,
              ),
              controller: txtController,
              onEditingComplete: () async {
                await QuestionManager().postAnswer3(
                    widget.Q_id!,
                    text: txtController.text);
                ref.changeIndex(1);
              },
            ),
          ),
        )
      ],
    );
  }
}
