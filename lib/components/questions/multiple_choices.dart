import 'package:effah/models/controller_reg.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../modules/basic_info_provider.dart';
import '../../managers/question_manager.dart';
import '../../models/question_model.dart';

class MultipleChoices extends StatefulWidget {
  MultipleChoices({
    Key? key,
    this.answers,
    this.Q_id,
    required this.question,
    required this.id,
  }) : super(key: key);
  String question;
  int? id;
  int? Q_id;
  List<Answers>? answers;

  @override
  State<MultipleChoices> createState() => _MultipleChoicesState();
}

class _MultipleChoicesState extends State<MultipleChoices> {
  bool press = false;

  bool isChecked = false;


  List<int> idList = [0];

  TextEditingController editingController = TextEditingController();

  //final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = [];

  List<bool> checkedlist = [];
  bool val = false;
  int? tapIndex ;

  @override
  void initState() {
    checkedlist = List<bool>.filled(widget.answers!.length, val);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref =
    Provider.of<ControllerReg>(context, listen: false);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };

      return white;
    }

    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.question,
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
            controller: editingController,
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
                          shrinkWrap: true,
                          itemCount: widget.answers!.length,
                          itemBuilder: (context, index) {
                            if (editingController.text.isEmpty) {
                              return InkWell(
                                onTap: () async {
                                  if (!idList.contains(widget.answers![index].id)) {
                                    if(widget.answers![index].isAnswer == 1){
                                      ref.changeIndex(index);
                                      setState((){
                                        tapIndex = null;
                                        press = false;
                                        checkedlist[index] = false;
                                        widget.answers![index].isAnswer = 0;
                                      });
                                    }else{
                                      ref.changeIndex(index);
                                     setState((){
                                       if (idList.length == 1 && idList[0] == 0){
                                         idList.clear();
                                       }
                                        idList.add(widget.answers![index].id!);
                                        tapIndex = index;
                                        press = true;
                                        checkedlist[index] = true;
                                        widget.answers![index].isAnswer = 1;
                                      });
                                    }

                                  }
                                  else{
                                    setState((){
                                      idList.removeWhere((element) => element == widget.answers![index].id);
                                      tapIndex = null;
                                      press = false;
                                      checkedlist[index] = false;
                                      widget.answers![index].isAnswer = 0;
                                    });
                                  }
                                  await QuestionManager().postAnswer2(widget.Q_id!, multiple_choice: idList);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 20.0.h, right: 10.w, left: 10.w),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.8,
                                        child: Checkbox(
                                          checkColor:
                                              tapIndex == index && press == true ||
                                              checkedlist[index] ||
                                              widget.answers![index].isAnswer == 1
                                              ? basicPink
                                              : grey,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                          value: (tapIndex == index &&
                                                      press == true) ||
                                                  widget.answers![index]
                                                          .isAnswer ==
                                                      1
                                              ? true
                                              : checkedlist[index],
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                            (states) => BorderSide(
                                                width: 1.0.w,
                                                color: (tapIndex == index &&
                                                            press == true) ||
                                                        checkedlist[index] ||
                                                        widget.answers![index]
                                                                .isAnswer ==
                                                            1
                                                    ? basicPink
                                                    : grey),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          onChanged: (bool? value) async {
                                            if (!idList.contains(widget.answers![index].id)) {
                                              if (idList.length == 1 && idList[0] == 0)
                                              {idList.clear();}
                                              idList.add(widget.answers![index].id!);
                                              ref.changeIndex(index);
                                              setState((){
                                                tapIndex = index;
                                                press = true;
                                                checkedlist[index] = true;
                                                widget.answers![index].isAnswer = 1;
                                              });
                                            }else{
                                              ref.changeIndex(index);
                                              setState((){
                                                tapIndex = null;
                                                press = false;
                                                checkedlist[index] = false;
                                                widget.answers![index].isAnswer = 0;
                                              });
                                            }
                                            await QuestionManager().postAnswer2(widget.Q_id!, multiple_choice: idList);
                                          },
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.answers![index].content!,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: (tapIndex == index &&
                                                        press == true) ||
                                                    checkedlist[index] ||
                                                    widget.answers![index]
                                                            .isAnswer ==
                                                        1
                                                ? basicPink
                                                : black),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            else if (widget.answers![index].content!
                                    .contains(editingController.text) ||
                                widget.answers![index].content!
                                    .contains(editingController.text)) {
                              return InkWell(
                                onTap: () async {
                                  if(checkedlist[index] == false){
                                    ref.changeIndex(index);
                                    setState(() {
                                      checkedlist[index] = true;
                                    });
                                    idList.add(widget.answers![index].id!);
                                  }else{
                                    idList.removeAt(index);
                                    setState(() {
                                      checkedlist[index] = false;
                                    });
                                  }
                                  await QuestionManager().postAnswer2(widget.Q_id!, multiple_choice: idList);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 20.0.h, right: 10.w, left: 10.w),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.8,
                                        child: Checkbox(
                                          checkColor: (tapIndex == index &&
                                                      press == true) ||
                                                  checkedlist[index] ||
                                                  widget.answers![index]
                                                          .isAnswer ==
                                                      1
                                              ? basicPink
                                              : grey,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                          value: (tapIndex == index &&
                                                      press == true) ||
                                                  widget.answers![index]
                                                          .isAnswer ==
                                                      1
                                              ? true
                                              : checkedlist[index],
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                            (states) => BorderSide(
                                                width: 1.0.w,
                                                color: (tapIndex == index &&
                                                            press == true) ||
                                                        checkedlist[index] ||
                                                        widget.answers![index]
                                                                .isAnswer ==
                                                            1
                                                    ? basicPink
                                                    : grey),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          onChanged: (bool? value) async
                                          {
                                            ref.changeIndex(index);
                                            if (value == true) {
                                              if (!idList.contains(widget.answers![index].id)) {
                                                if (idList.length == 1 &&
                                                    idList[0] == 0) {
                                                  idList.clear();
                                                }
                                                idList.add(
                                                    widget.answers![index].id!);
                                              }
                                              else {
                                                setState(() {
                                                  idList.remove(
                                                      widget.answers![index].id!);
                                                });
                                              }
                                              setState((){
                                                tapIndex = index;
                                                press = true;
                                                checkedlist[index] = true;
                                              });
                                              await QuestionManager().postAnswer2(widget.Q_id!, multiple_choice: idList);
                                            }else{
                                              setState((){
                                                tapIndex = null;
                                                press = false;
                                                checkedlist[index] = false;
                                                widget.answers![index].isAnswer = 0;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.answers![index].content!,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: (tapIndex == index &&
                                                        press == true) ||
                                                    checkedlist[index] ||
                                                    widget.answers![index]
                                                            .isAnswer ==
                                                        1
                                                ? basicPink
                                                : black),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ))))
    ]);
  }

  void _updateProgress(BuildContext context) {
    Provider.of<InfoProvider>(context, listen: false).progressValue += 0.2;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }
}
