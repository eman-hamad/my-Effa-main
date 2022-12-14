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

class OneChoice extends StatefulWidget {
  OneChoice(
      {Key? key,
      required this.question,
      required this.id,
        this.answers,
      this.Q_id,
      required this.editingController,

      })
      : super(key: key);
  String question;
  int? id;
  int? Q_id;
  List<Answers>? answers;
  TextEditingController editingController;

  @override
  State<OneChoice> createState() => _OneChoiceState();
}

class _OneChoiceState extends State<OneChoice> {
  int? myID;

  bool press = false;

 

  int? tapIndex;

  int? updatedID;
  int? questionID;
  List<Answers>? oneQuestion;
  @override
  Widget build(BuildContext context) {
    final ref =
    Provider.of<ControllerReg>(context, listen: false);
    return Column(children: [
      updatedID == null
          ? Consumer<InfoProvider>(builder: (_, a, child) {
              return Text(
                "${widget.question}",
                style: TextStyle(fontSize: 20.sp),
                textAlign: TextAlign.center,
              );
            })
          : Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Align(
          alignment: Alignment.center,
          child: Text(
             "${widget.question}",
            style: TextStyle(fontSize: 20.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Padding(
        padding:
            EdgeInsets.only(right: 30.w, left: 30.w, bottom: 8.h, top: 8.h),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            cursorColor: basicPink,
            onChanged: (value) {
              Provider.of<InfoProvider>(context, listen: false).rebuild();
            },
            controller: widget.editingController,
            decoration: const InputDecoration(
              hintText: " بحث ... ",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: grey),
              ),
              focusColor: basicPink,
              fillColor: basicPink,
              prefixIcon: Icon(
                Icons.search,
                color: basicPink,
              ),
            ),
          ),
        ),
      ),
      Expanded(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          alignment: Alignment.centerRight,
          child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: llgrey, width: 1.w),
                borderRadius: BorderRadius.circular(15),
              ),
              color: white,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: widget.answers!.length,
                      itemBuilder: (context, index) {
                        if (widget
                            .editingController.text.isEmpty) {
                          return InkWell(
                            onTap: () async {
                              ref.changeIndex(index);
                              setState(() {
                                for(int i =0;i < widget.answers!.length ; i++){
                                  widget.answers![i].isAnswer = 0;
                                }
                                  tapIndex = index;
                                  press =true;
                              });
                              await QuestionManager().postAnswer(widget.Q_id!, one_choice: widget.answers![index].id!);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 12.0.h,
                                  top: 12.0.h,
                                  right: 10.w,
                                  left: 10.w),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 30,
                                      color: (tapIndex == index && press == true) ||
                                          widget.answers![index].isAnswer == 1
                                          ? basicPink
                                          : transparnt,
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.answers![index]
                                          .content!,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: (tapIndex ==
                                              index &&
                                              press ==
                                                  true) ||
                                              widget.answers![
                                              index]
                                                  .isAnswer ==
                                                  1
                                              ? basicPink
                                              : black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (widget.answers![index].content!
                            .contains(widget
                            .editingController.text) ||
                            widget.answers![index].content!
                                .contains(widget
                                .editingController.text)) {
                          return InkWell(
                            onTap: () async {
                              ref.changeIndex(index);
                              setState(() {
                                for(int i =0;i < widget.answers!.length ; i++){
                                  widget.answers![i].isAnswer = 0;
                                }

                                  tapIndex = index;
                                  press =true;

                              });
                              await QuestionManager().postAnswer(widget.Q_id!, one_choice: widget.answers![index].id!);
                              widget.editingController.clear();
                              FocusScope.of(context).unfocus();
                              // Provider.of<InfoProvider>(context,
                              //     listen: false)
                              //     .rebuild();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 12.0.h,
                                  top: 12.0.h,
                                  right: 10.w,
                                  left: 10.w),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 30,
                                      color: (tapIndex == index && press == true) || widget.answers![index].isAnswer == 1
                                          ? basicPink
                                          : transparnt,
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.answers![index]
                                          .content!,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: (tapIndex == index &&
                                              press == true) ||
                                              widget.answers![index].isAnswer == 1
                                              ? basicPink
                                              : black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
              )),
        ),
      ))
    ]);
  }
}
