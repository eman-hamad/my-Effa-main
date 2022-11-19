import 'package:effah/constants.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../modules/basic_info_provider.dart';
import '../../managers/question_manager.dart';
import '../../models/question_model.dart';

class TextQuestion extends StatelessWidget {
  TextQuestion(
      {Key? key,
      required this.progress,
      this.questions,
      required this.myIndex,
      required this.id,
      required this.myLength})
      : super(key: key);
  late double progress;
  int myIndex;
  int myLength;
  int? id;
  Future<List<Question>>? questions;

  bool press = false;

  late double _progressValue = progress;

  TextEditingController txtController = TextEditingController();
  int tapIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("questions");
    print(myLength);

    print(questions);

    return Consumer<InfoProvider>(builder: (_, a, child) {
      return FutureBuilder<List<Question>>(
          future: questions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      snapshot.data![myIndex].content!,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  )),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 15.w, left: 15.w, top: 10.h),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onTap: () {
              if (txtController.selection ==
                  TextSelection.fromPosition(TextPosition(
                      offset: txtController.text.length - 1))) {
                // setState(() {
                txtController.selection = TextSelection.fromPosition(
                    TextPosition(offset: txtController.text.length));
                Provider.of<InfoProvider>(context, listen: false).rebuild();

                // });
              }
            },
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
                          await QuestionManager().postAnswer(
                              id!, snapshot.data![myIndex].id!,
                              text: txtController.text);
                        },
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
