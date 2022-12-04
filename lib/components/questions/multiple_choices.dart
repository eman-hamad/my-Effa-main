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

class MultipleChoices extends StatelessWidget {
  MultipleChoices(
      {Key? key,
   
      this.questions,
      required this.myIndex,
      required this.id,
      required this.myLength})
      : super(key: key);
  
  int myIndex;
  int myLength;
  int? id;
  Future<List<Question>>? questions;

  bool press = false;
  bool isChecked = false;
  late bool _loading;
  List<int> idList = [0];

  TextEditingController editingController = TextEditingController();

  //final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = [];

  List<bool> checkedlist = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  int tapIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };

      return white;
    }

    return Column(children: [
      FutureBuilder<List<Question>>(
          future: questions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    snapshot.data![myIndex].content!,
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
                  child: Consumer<InfoProvider>(builder: (_, a, child) {
                    return FutureBuilder<List<Question>>(
                        future: questions,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    snapshot.data![myIndex].answers!.length,
                                itemBuilder: (context, index) {
                                  if (editingController.text.isEmpty) {
                                    return InkWell(
                                      onTap: () async {
                                        tapIndex = index;

                                        press = true;

                                        if (!idList.contains(snapshot
                                            .data![myIndex]
                                            .answers![index]
                                            .id)) {
                                          if (idList.length == 1 &&
                                              idList[0] == 0) {
                                            idList.clear();
                                          }

                                          idList.add(snapshot.data![myIndex]
                                              .answers![index].id!);
                                        }

                                        print("idList");
                                        print(idList);
                                        await QuestionManager().postAnswer(
                                            id!, snapshot.data![myIndex].id!,
                                            index: index,
                                            len: snapshot
                                                .data![myIndex].answers!,
                                            multiple_choice: idList);

                                        Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .rebuild();

                                        _updateProgress(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 20.0.h,
                                            right: 10.w,
                                            left: 10.w),
                                        child: Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.8,
                                              child: Checkbox(
                                                checkColor: (tapIndex ==
                                                                index &&
                                                            press == true) ||
                                                        checkedlist[index] ||
                                                        snapshot
                                                                .data![myIndex]
                                                                .answers![index]
                                                                .isAnswer ==
                                                            1
                                                    ? basicPink
                                                    : grey,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith(getColor),
                                                value: (tapIndex == index &&
                                                            press == true) ||
                                                        snapshot
                                                                .data![myIndex]
                                                                .answers![index]
                                                                .isAnswer ==
                                                            1
                                                    ? true
                                                    : checkedlist[index],
                                                side: MaterialStateBorderSide
                                                    .resolveWith(
                                                  (states) => BorderSide(
                                                      width: 1.0.w,
                                                      color: (tapIndex ==
                                                                      index &&
                                                                  press ==
                                                                      true) ||
                                                              checkedlist[
                                                                  index] ||
                                                              snapshot
                                                                      .data![
                                                                          myIndex]
                                                                      .answers![
                                                                          index]
                                                                      .isAnswer ==
                                                                  1
                                                          ? basicPink
                                                          : grey),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                onChanged: (bool? value) async {
                                                  Provider.of<InfoProvider>(
                                                          context,
                                                          listen: false)
                                                      .rebuild();
                                                  checkedlist[index] = value!;

                                                  if (value == true) {
                                                    print("ssssssssssssssssss");
                                                    if (!idList.contains(
                                                        snapshot
                                                            .data![myIndex]
                                                            .answers![index]
                                                            .id)) {
                                                      if (idList.length == 1 &&
                                                          idList[0] == 0) {
                                                        idList.clear();
                                                      }

                                                      idList.add(snapshot
                                                          .data![myIndex]
                                                          .answers![index]
                                                          .id!);
                                                    } else {
                                                      idList.remove(snapshot
                                                          .data![myIndex]
                                                          .answers![index]
                                                          .id!);
                                                      print("idList");
                                                      print(idList);
                                                    }

                                                    print("idList");
                                                    print(idList);
                                                    await QuestionManager()
                                                        .postAnswer(
                                                            id!,
                                                            snapshot
                                                                .data![myIndex]
                                                                .id!,
                                                            index: index,
                                                            len: snapshot
                                                                .data![myIndex]
                                                                .answers!,
                                                            multiple_choice:
                                                                idList);
                                                    Provider.of<InfoProvider>(
                                                            context,
                                                            listen: false)
                                                        .rebuild();
                                                  }
                                                },
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              snapshot.data![myIndex]
                                                  .answers![index].content!,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: (tapIndex == index &&
                                                              press == true) ||
                                                          checkedlist[index] ||
                                                          snapshot
                                                                  .data![
                                                                      myIndex]
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
                                  } else if (snapshot.data![myIndex]
                                          .answers![index].content!
                                          .contains(editingController.text) ||
                                      snapshot.data![myIndex].answers![index]
                                          .content!
                                          .contains(editingController.text)) {
                                    return InkWell(
                                      onTap: () async {
                                        tapIndex = index;

                                        press = true;
                                        if (!idList.contains(snapshot
                                            .data![myIndex]
                                            .answers![index]
                                            .id)) {
                                          if (idList.length == 1 &&
                                              idList[0] == 0) {
                                            idList.clear();
                                          }

                                          idList.add(snapshot.data![myIndex]
                                              .answers![index].id!);
                                        }

                                        print("idList");
                                        print(idList);
                                        await QuestionManager().postAnswer(
                                            id!, snapshot.data![myIndex].id!,
                                            index: index,
                                            len: snapshot
                                                .data![myIndex].answers!,
                                            multiple_choice: idList);

                                        Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .rebuild();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 20.0.h,
                                            right: 10.w,
                                            left: 10.w),
                                        child: Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.8,
                                              child: Checkbox(
                                                checkColor: (tapIndex ==
                                                                index &&
                                                            press == true) ||
                                                        checkedlist[index] ||
                                                        snapshot
                                                                .data![myIndex]
                                                                .answers![index]
                                                                .isAnswer ==
                                                            1
                                                    ? basicPink
                                                    : grey,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith(getColor),
                                                value: (tapIndex == index &&
                                                            press == true) ||
                                                        snapshot
                                                                .data![myIndex]
                                                                .answers![index]
                                                                .isAnswer ==
                                                            1
                                                    ? true
                                                    : checkedlist[index],
                                                side: MaterialStateBorderSide
                                                    .resolveWith(
                                                  (states) => BorderSide(
                                                      width: 1.0.w,
                                                      color: (tapIndex ==
                                                                      index &&
                                                                  press ==
                                                                      true) ||
                                                              checkedlist[
                                                                  index] ||
                                                              snapshot
                                                                      .data![
                                                                          myIndex]
                                                                      .answers![
                                                                          index]
                                                                      .isAnswer ==
                                                                  1
                                                          ? basicPink
                                                          : grey),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                onChanged: (bool? value) async {
                                                  Provider.of<InfoProvider>(
                                                          context,
                                                          listen: false)
                                                      .rebuild();
                                                  checkedlist[index] = value!;
                                                if (value == true) {
                                                    print("ssssssssssssssssss");
                                                    if (!idList.contains(
                                                        snapshot
                                                            .data![myIndex]
                                                            .answers![index]
                                                            .id)) {
                                                      if (idList.length == 1 &&
                                                          idList[0] == 0) {
                                                        idList.clear();
                                                      }

                                                      idList.add(snapshot
                                                          .data![myIndex]
                                                          .answers![index]
                                                          .id!);
                                                    } else {
                                                      idList.remove(snapshot
                                                          .data![myIndex]
                                                          .answers![index]
                                                          .id!);
                                                      print("idList");
                                                      print(idList);
                                                    }

                                                    print("idList");
                                                    print(idList);
                                                    await QuestionManager()
                                                        .postAnswer(
                                                            id!,
                                                            snapshot
                                                                .data![myIndex]
                                                                .id!,
                                                            index: index,
                                                            len: snapshot
                                                                .data![myIndex]
                                                                .answers!,
                                                            multiple_choice:
                                                                idList);
                                                    Provider.of<InfoProvider>(
                                                            context,
                                                            listen: false)
                                                        .rebuild();
                                                  }
                                                },
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              snapshot.data![myIndex]
                                                  .answers![index].content!,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: (tapIndex == index &&
                                                              press == true) ||
                                                          checkedlist[index] ||
                                                          snapshot
                                                                  .data![
                                                                      myIndex]
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
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  }))),
        ),
      ))
    ]);
  }

  void _updateProgress(BuildContext context) {
    Provider.of<InfoProvider>(context, listen: false).progressValue += 0.2;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }
}
