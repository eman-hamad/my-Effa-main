import 'package:effah/constants.dart';
import 'package:effah/managers/question_manager.dart';
import 'package:effah/models/question_model.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

import '../../../../components/questions/multiple_choices.dart';
import '../../../../components/questions/one_choice.dart';
import '../../../../components/questions/text_question.dart';
import '../../../../modules/basic_info_provider.dart';

import 'options.dart';

class FatherInfo extends StatelessWidget {
  FatherInfo(
      {Key? key,
      required this.progress,
      required this.id,
      required this.gender})
      : super(key: key);
  late double progress;
  int gender;
  int? id;

  bool press = false;

  late double _progressValue = progress;
  TextEditingController editingController = TextEditingController();

  int tapIndex = 0;
  static int myLen = 0;
  static int femaleLen = 0;
  // Future<List<Question>>? maleQuestionList;
  Future<List<Question>>? femaleQuestionList;
  final controller = SwiperController();

  var g, myfLen, k;
  int h = 0;
  int len = 0;
  int fLen = 0;
  getLength() async {
    // myLen = g.length;
    k = await QuestionManager().getQuestions(id!, 5, 1);
    myLen = k.length;

    myfLen = await QuestionManager().getQuestions(id!, 5, 2);
    femaleLen = myfLen.length;

    // print(g.length);
    // len = g.length;
    // print("len");
    // print(myLen);
  }

  @override
  Widget build(BuildContext context) {
    //  final model = Provider.of<AppStateProvider>(context, listen: false);

    //maleQuestionList = QuestionManager().getQuestion(id!, 5, 1);
    femaleQuestionList = QuestionManager().getQuestions(id!, 5, 2);
Future<List<Question>> list=QuestionManager().getQuestions(id!, 5, gender);
list.then((value) {
      print("gender ");
      print(QuestionManager.len);
      print(Provider.of<InfoProvider>(context, listen: false)
          .educationProgressValue);
      Provider.of<InfoProvider>(context, listen: false).parentProgressValue =
          1 / QuestionManager.len;
    });
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: transparnt,
      // ),
      body: Column(children: [
        SizedBox(
          height: 65.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                SvgPicture.asset("assets/icon/nextto.svg"),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "بيانات ولي الأمر",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, bottom: 45.h, top: 20.h),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Consumer<InfoProvider>(builder: (_, a, child) {
                    return LinearProgressIndicator(
                      minHeight: 9.h,
                      backgroundColor: bgrey,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(basicPink),
                      value: Provider.of<InfoProvider>(context, listen: false)
                          .parentProgressValue,
                    );
                  }),
                )),
          ),
        ),
        FutureBuilder<List<Question>>(
            future: femaleQuestionList,
            builder: (context, snapshot) {
              // print("myIndex");
              // print(myIndex);
              // print("snapshot");
              // print(snapshot.data![0].content);
              if (snapshot.hasData) {
                return Expanded(
                  //  flex: 3,
                  child: Swiper(
                    controller: controller,
                    onIndexChanged: (value) {
                      Provider.of<InfoProvider>(context, listen: false)
                          .myIndexParent = value;
                    },
                    loop: false,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int x) {
                      // getLength().then((v) {
                      //   print("vvvvvvvvvvvv");
                      //   print(femaleLen);
                      //   // myLen = len;
                      // });

                      if (snapshot.data![x].type == 1) {
                        return Center(
                          child: TextQuestion(
                              id: id,
                              myLength: gender == 1 ? myLen : femaleLen,
                              progress: _progressValue,
                              questions:
                                  // gender == 1
                                  //     ? maleQuestionList
                                  //     :
                                  femaleQuestionList,
                              myIndex: Provider.of<InfoProvider>(context,
                                      listen: false)
                                  .myIndexParent),
                        );
                      } else if (snapshot.data![x].type == 2 ||
                          snapshot.data![x].type == 4) {
                        return Center(
                          child: OneChoice(
                              gender: gender,
                              editingController: editingController,
                              id: id,
                              myLength: gender == 1 ? myLen : femaleLen,
                              progress: _progressValue,
                              questions: femaleQuestionList,
                              myIndex: Provider.of<InfoProvider>(context,
                                      listen: false)
                                  .myIndexParent),
                        );
                      } else {
                        return Center(
                          child: MultipleChoices(
                              id: id,
                              myLength: gender == 1 ? myLen : femaleLen,
                              progress: _progressValue,
                              questions: femaleQuestionList,
                              myIndex: Provider.of<InfoProvider>(context,
                                      listen: false)
                                  .myIndexParent),
                        );
                      }
                    },
                    itemCount: QuestionManager.len,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        Consumer<InfoProvider>(builder: (_, a, child) {
          if (Provider.of<InfoProvider>(context, listen: false).myIndexParent ==
              0) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5.w,
                        // assign the color to the border color
                        color: transparnt,
                      ),
                      color: basicPink,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      child: Text('تخطي',
                          style: TextStyle(
                            color: white,
                            fontSize: 16.sp,
                            // fontWeight: FontWeight.w500
                          )),
                      style: TextButton.styleFrom(
                        // backgroundColor: const Color(0xffff8297),
                        // primary: Colors.teal,
                        // onSurface: Colors.yellow,
                        // side: BorderSide(color: Colors.teal, width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        _updateProgress(context);
                        controller.next();

                        increment(context);
                      },
                    ),
                  ),
                ));
          } else if (Provider.of<InfoProvider>(context, listen: false)
                  .myIndexParent ==
              QuestionManager.len - 1) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: transparnt,
                      border: Border.all(
                        width: 1.5.w,
                        // assign the color to the border color
                        color: black,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      child: Text('السابق',
                          style: TextStyle(
                            color: black,
                            fontSize: 16.sp,
                            //fontWeight: FontWeight.w500
                          )),
                      style: TextButton.styleFrom(
                        // backgroundColor: const Color(0xffff8297),
                        // primary: Colors.teal,
                        // onSurface: Colors.yellow,
                        // side: BorderSide(color: Colors.teal, width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        _removeProgress(context);
                        controller.previous();

                        decrement(context);
                      },
                    ),
                  ),
                ));
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                width: double.infinity,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5.w,
                          // assign the color to the border color
                          color: transparnt,
                        ),
                        color: basicPink,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                        child: Text('تخطي',
                            style: TextStyle(
                              color: white,
                              fontSize: 16.sp,
                              // fontWeight: FontWeight.w500
                            )),
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {
                          _updateProgress(context);

                          controller.next();

                          increment(context);
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: SizedBox(
                      width: 25.w,
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: transparnt,
                          border: Border.all(
                            width: 1.5.w,
                            // assign the color to the border color
                            color: black,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextButton(
                          child: Text('السابق',
                              style: TextStyle(
                                color: black,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
                              )),
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            _removeProgress(context);
                            controller.previous();

                            decrement(context);

                            // // _updateProgress(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Options(
                            //               gender: 0,
                            //               progress: _progressValue,
                            //               id: id,
                            //             )));
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }
        }),
        SizedBox(
          height: 30.h,
        ),
        GestureDetector(
          onTap: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Options(
                          gender: 0,
                          id: id,
                          progress: _progressValue,
                        )));
          }),
          child: Text(
            "الانهاء في وقت اخر",
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ]),
    );
  }

  // Future<List<Question>> getQuestions() async {
  //   return await QuestionManager().getQuestions(id!, 5, gender);
  // }

  void increment(BuildContext context) {
    // setState(() {
    // visible = true;
    Provider.of<InfoProvider>(context, listen: false).myIndexParent++;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
    // });
  }

  void decrement(BuildContext context) {
    // setState(() {
    // visible = true;
    Provider.of<InfoProvider>(context, listen: false).myIndexParent--;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
    // });
  }

  void _updateProgress(BuildContext context) {
    //Provider.of<InfoProvider>(context, listen: false).updateProgress(_progressValue);
    Provider.of<InfoProvider>(context, listen: false).parentProgressValue +=
        1 / QuestionManager.len;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _removeProgress(BuildContext context) {
    if (Provider.of<InfoProvider>(context, listen: false).parentProgressValue !=
        (1.0 - (1 / QuestionManager.len))) {
      Provider.of<InfoProvider>(context, listen: false).parentProgressValue -=
          1 / QuestionManager.len;
      Provider.of<InfoProvider>(context, listen: false).rebuild();
    }
  }
}
