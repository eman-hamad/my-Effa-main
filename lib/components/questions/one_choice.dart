import 'package:effah/constants.dart';
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
      
      this.questions,
      required this.myIndex,
      required this.id,
      this.height,
      required this.gender,
      this.category_id,
      required this.editingController,
      required this.myLength})
      : super(key: key);
 
  int myIndex;
  int myLength;
  double? height;
  int? id;
  int gender;
  int? category_id;
  TextEditingController editingController;

  Future<List<Question>>? questions;

  @override
  State<OneChoice> createState() => _OneChoiceState();
}

class _OneChoiceState extends State<OneChoice> {
  int? myID;

  bool press = false;

 

  int tapIndex = 0;

  int? updatedID;
  int? questionID;
  Future<Question>? oneQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      updatedID == null
          ? Consumer<InfoProvider>(builder: (_, a, child) {
              return FutureBuilder<List<Question>>(
                  future: widget.questions,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //  myID = snapshot.data![myIndex].quId;
                      A:
                      for (int i = widget.myIndex;
                          i < snapshot.data!.length;
                          i++) {
                        if (snapshot.data![widget.myIndex].quId != null) {
                          widget.myIndex++;
                          //QuestionManager.len=5;
                        } else {
                          break A;
                        }
                      }
                      questionID = snapshot.data![widget.myIndex].quId;
                      print("1");
                      // print(widget.myIndex);
                      // B:
                      // for (int i = 0; i < snapshot.data!.length; i++) {
                      // A:
                      // if (questionID != null) {
                      //   widget.myIndex += 1;
                      //   print("2");
                      //   // print(questionID);
                      //   // print(widget.myIndex);
                      //   continue A;
                      // } else {
                      //   print("wow");
                      //   // print(widget.myIndex);
                      //   // print(questionID);

                      //   break A;
                      // }
                      //
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            snapshot.data![widget.myIndex].content!,

                            //: snapshot.d,
                            // : snapshot.data!.map((e) {
                            //     // if (e.id == 20) {
                            //     e.id.toString();
                            //     //  } else {
                            //     //   "";
                            //     // }
                            //   }).toString(),
                            style: TextStyle(fontSize: 20.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      // }
                      // return Text("");
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            })
          : FutureBuilder<Question>(
              future: oneQuestion,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // myID = snapshot.data!.quId;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        snapshot.data!.content!,
                        // : snapshot.data!.map((e) {
                        //     // if (e.id == 20) {
                        //     e.id.toString();
                        //     //  } else {
                        //     //   "";
                        //     // }
                        //   }).toString(),
                        style: TextStyle(fontSize: 20.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
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
                  child: Consumer<InfoProvider>(builder: (_, a, child) {
                    return updatedID == null
                        ? FutureBuilder<List<Question>>(
                            future: widget.questions,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                //  myID = snapshot.data![myIndex].quId;
                                A:
                                for (int i = widget.myIndex;
                                    i < snapshot.data!.length;
                                    i++) {
                                  if (snapshot.data![widget.myIndex].quId !=
                                      null) {
                                    widget.myIndex++;
                                  } else {
                                    break A;
                                  }
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot
                                        .data![widget.myIndex].answers!.length,
                                    itemBuilder: (context, index) {
                                      if (widget
                                          .editingController.text.isEmpty) {
                                        return InkWell(
                                          onTap: () async {
                                            tapIndex = index;
                                            if (snapshot
                                                    .data![widget.myIndex]
                                                    .answers![index]
                                                    .related_qu_id !=
                                                null) {
                                              updatedID = snapshot
                                                  .data![widget.myIndex]
                                                  .answers![index]
                                                  .related_qu_id;
                                              // oneQuestion =
                                              oneQuestion = QuestionManager()
                                                  .getQuestion(
                                                      widget.id!,
                                                      widget.category_id!,
                                                      widget.gender,
                                                      updatedID!);
                                              setState(() {});
                                              // await getQuestion().then((value) {
                                              //   print("value");
                                              //   print(oneQuestion);
                                              // });

                                              print("oneQuestion");
                                              print(oneQuestion);
                                              // print("updatedID");
                                              // print(updatedID);

                                              // print("content ");
                                              // print(snapshot.data!.map((e) {
                                              //   e.id == updatedID
                                              //       ? e.content.toString()
                                              //       : print("ff");
                                              // }).toList());

                                              // snapshot.data!.map((e) {
                                              //   //e.id.toString() == updatedID.toString();
                                              //   print(updatedID);
                                              //   print(e.id.toString());
                                              //   if (e.id == updatedID) {
                                              //     print("hi");
                                              //   }
                                              // ? print("e.content.toString()")
                                              // : print("object");
                                              // }).toList();
                                            }
                                            await QuestionManager().postAnswer(
                                              widget.id!,
                                              snapshot
                                                  .data![widget.myIndex].id!,
                                              one_choice: snapshot
                                                  .data![widget.myIndex]
                                                  .answers![index]
                                                  .id!,
                                            );
                                            Provider.of<InfoProvider>(context,
                                                    listen: false)
                                                .rebuild();

                                            press = true;
                                            Provider.of<InfoProvider>(context,
                                                    listen: false)
                                                .rebuild();

                                            oneQuestion = null;
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 30.0.h,
                                                right: 10.w,
                                                left: 10.w),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  size: 30,
                                                  color: (tapIndex == index &&
                                                              press == true) ||
                                                          snapshot
                                                                  .data![widget
                                                                      .myIndex]
                                                                  .answers![
                                                                      index]
                                                                  .isAnswer ==
                                                              1
                                                      ? basicPink
                                                      : transparnt,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  snapshot.data![widget.myIndex]
                                                      .answers![index].content!,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: (tapIndex ==
                                                                      index &&
                                                                  press ==
                                                                      true) ||
                                                              snapshot
                                                                      .data![widget
                                                                          .myIndex]
                                                                      .answers![
                                                                          index]
                                                                      .isAnswer ==
                                                                  1
                                                          ? basicPink
                                                          : black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (snapshot.data![widget.myIndex]
                                              .answers![index].content!
                                              .contains(widget
                                                  .editingController.text) ||
                                          snapshot.data![widget.myIndex]
                                              .answers![index].content!
                                              .contains(widget
                                                  .editingController.text)) {
                                        return InkWell(
                                          onTap: () async {
                                            tapIndex = index;
                                            if (snapshot
                                                    .data![widget.myIndex]
                                                    .answers![index]
                                                    .related_qu_id !=
                                                null) {
                                              updatedID = snapshot
                                                  .data![widget.myIndex]
                                                  .answers![index]
                                                  .related_qu_id;
                                              // oneQuestion =
                                              oneQuestion = QuestionManager()
                                                  .getQuestion(
                                                      widget.id!,
                                                      widget.category_id!,
                                                      widget.gender,
                                                      updatedID!);
                                              setState(() {});
                                            }

                                            await QuestionManager().postAnswer(
                                              widget.id!,
                                              snapshot
                                                  .data![widget.myIndex].id!,
                                              one_choice: snapshot
                                                  .data![widget.myIndex]
                                                  .answers![index]
                                                  .id!,
                                            );

                                            press = true;

                                            widget.editingController.clear();
                                            FocusScope.of(context).unfocus();
                                            Provider.of<InfoProvider>(context,
                                                    listen: false)
                                                .rebuild();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 30.0.h,
                                                right: 10.w,
                                                left: 10.w),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  size: 30,
                                                  color: (tapIndex == index &&
                                                              press == true) ||
                                                          snapshot
                                                                  .data![widget
                                                                      .myIndex]
                                                                  .answers![
                                                                      index]
                                                                  .isAnswer ==
                                                              1
                                                      ? basicPink
                                                      : transparnt,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  snapshot.data![widget.myIndex]
                                                      .answers![index].content!,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: (tapIndex ==
                                                                      index &&
                                                                  press ==
                                                                      true) ||
                                                              snapshot
                                                                      .data![widget
                                                                          .myIndex]
                                                                      .answers![
                                                                          index]
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
                                    });
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                        : FutureBuilder<Question>(
                            future: oneQuestion,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                //  myID = snapshot.data![myIndex].quId;
                                // A:
                                // for (int i = widget.myIndex;
                                //     i < snapshot.data!.length;
                                //     i++) {
                                //   if (snapshot.data![widget.myIndex].quId != null) {
                                //     widget.myIndex++;
                                //   } else {
                                //     break A;
                                //   }
                                // }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.answers!.length,
                                    itemBuilder: (context, index) {
                                      if (widget
                                          .editingController.text.isEmpty) {
                                        return InkWell(
                                          onTap: () async {
                                            tapIndex = index;
                                            if (snapshot.data!.answers![index]
                                                    .related_qu_id !=
                                                null) {
                                              updatedID = snapshot
                                                  .data!
                                                  .answers![index]
                                                  .related_qu_id;
                                              // oneQuestion =
                                              oneQuestion = QuestionManager()
                                                  .getQuestion(8, 2, 2, 22);
                                              setState(() {});
                                              // await getQuestion().then((value) {
                                              //   print("value");
                                              //   print(oneQuestion);
                                              // });

                                              print("oneQuestion");
                                              print(oneQuestion);
                                              // print("updatedID");
                                              // print(updatedID);

                                              // print("content ");
                                              // print(snapshot.data!.map((e) {
                                              //   e.id == updatedID
                                              //       ? e.content.toString()
                                              //       : print("ff");
                                              // }).toList());

                                              // snapshot.data!.map((e) {
                                              //   //e.id.toString() == updatedID.toString();
                                              //   print(updatedID);
                                              //   print(e.id.toString());
                                              //   if (e.id == updatedID) {
                                              //     print("hi");
                                              //   }
                                              // ? print("e.content.toString()")
                                              // : print("object");
                                              // }).toList();
                                            }
                                            await QuestionManager().postAnswer(
                                              widget.id!,
                                              snapshot.data!.id!,
                                              one_choice: snapshot
                                                  .data!.answers![index].id!,
                                            );
                                            Provider.of<InfoProvider>(context,
                                                    listen: false)
                                                .rebuild();

                                            press = true;
                                            Provider.of<InfoProvider>(context,
                                                    listen: false)
                                                .rebuild();

                                            oneQuestion = null;
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 30.0.h,
                                                right: 10.w,
                                                left: 10.w),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  size: 30,
                                                  color: (tapIndex == index &&
                                                              press == true) ||
                                                          snapshot
                                                                  .data!
                                                                  .answers![
                                                                      index]
                                                                  .isAnswer ==
                                                              1
                                                      ? basicPink
                                                      : transparnt,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  snapshot.data!.answers![index]
                                                      .content!,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: (tapIndex ==
                                                                      index &&
                                                                  press ==
                                                                      true) ||
                                                              snapshot
                                                                      .data!
                                                                      .answers![
                                                                          index]
                                                                      .isAnswer ==
                                                                  1
                                                          ? basicPink
                                                          : black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (snapshot
                                              .data!.answers![index].content!
                                              .contains(widget
                                                  .editingController.text) ||
                                          snapshot
                                              .data!.answers![index].content!
                                              .contains(widget
                                                  .editingController.text)) {
                                        return InkWell(
                                          onTap: () async {
                                            tapIndex = index;
                                            await QuestionManager().postAnswer(
                                              widget.id!,
                                              snapshot.data!.id!,
                                              one_choice: snapshot
                                                  .data!.answers![index].id!,
                                            );

                                            press = true;

                                            widget.editingController.clear();
                                            FocusScope.of(context).unfocus();
                                            Provider.of<InfoProvider>(context,
                                                    listen: false)
                                                .rebuild();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 30.0.h,
                                                right: 10.w,
                                                left: 10.w),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  size: 30,
                                                  color: (tapIndex == index &&
                                                              press == true) ||
                                                          snapshot
                                                                  .data!
                                                                  .answers![
                                                                      index]
                                                                  .isAnswer ==
                                                              1
                                                      ? basicPink
                                                      : transparnt,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  snapshot.data!.answers![index]
                                                      .content!,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: (tapIndex ==
                                                                      index &&
                                                                  press ==
                                                                      true) ||
                                                              snapshot
                                                                      .data!
                                                                      .answers![
                                                                          index]
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
                                    });
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            });
                  }))),
        ),
      ))
    ]);
  }
}
