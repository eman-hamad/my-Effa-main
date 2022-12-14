

import 'package:effah/constants.dart';
import 'package:effah/managers/question_manager.dart';
import 'package:effah/models/controller_reg.dart';
import 'package:effah/models/question_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

import '../../../../components/questions/multiple_choices.dart';
import '../../../../components/questions/one_choice.dart';
import '../../../../components/questions/text_question.dart';
import '../../../../models/user_model.dart';
import '../../../../modules/basic_info_provider.dart';
import '../options.dart';

class SocialStatus extends StatefulWidget {
  SocialStatus(
      {Key? key,
   
      required this.id,
      required this.gender})
      : super(key: key);
  
  int gender;
  int? id;

  static int myLen = 0;
  static int femaleLen = 0;

  @override
  State<SocialStatus> createState() => _SocialStatusState();
}

class _SocialStatusState extends State<SocialStatus> {
  bool press = false;

  // late bool _loading;
  TextEditingController editingController = TextEditingController();

  int tapIndex = 0;

  Future<List<Question>>? maleQuestionList;

  Future<List<Question>>? femaleQuestionList;

  Future<Question>? oneQuestion;


  PageController controller = PageController();

  var g, myfLen, k;

  int h = 0;

  int len = 0;
  int level = 1;

  int fLen = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(children: [
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
                    'الدين & الحالة الأجتماعية',
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
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, bottom: 45.h, top: 20.h),
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
                            .religionProgressValue,
                      );
                    }),
                  )),
            ),
          ),
          FutureBuilder<List<Question>>(
              future:  QuestionManager().getQuestions(2, level,context),
              builder: (context, snapshot) {
                final ref = Provider.of<ControllerReg>(context, listen: true);
                if (snapshot.hasData) {
                  return  snapshot.hasError? Center(child: CircularProgressIndicator(),):Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.5,
                        child: PageView.builder(
                          controller: controller,
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (value){
                            print(value);
                            print(QuestionManager.len== tapIndex+2);
                            setState(() {
                              tapIndex = value;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int x) {

                            if (snapshot.data![x].type == 1) {
                              return Center(
                                child: TextQuestion(
                                  id: widget.id,
                                  Q_id:  snapshot.data![x].id,
                                  question: snapshot.data![x].content!,
                                  answers: snapshot.data![x].answers,),
                              );
                            } else if (snapshot.data![x].type == 2 || snapshot.data![x].type == 4) {
                              return Center(
                                child: OneChoice(
                                  editingController: editingController,
                                  id: widget.id,
                                  Q_id:  snapshot.data![x].id,
                                  answers: snapshot.data![x].answers,
                                  question: snapshot.data![x].content!,),
                              );
                            } else {
                              return Center(
                                child: MultipleChoices(
                                  id: widget.id,
                                  Q_id: snapshot.data![x].id,
                                  question:snapshot.data![x].content!,
                                  answers:snapshot.data![x].answers,
                                ),
                              );
                            }
                          },
                          itemCount: QuestionManager.len,
                        ),
                      ),
                      tapIndex ==0?
                      Padding(
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
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: TextButton(
                                child: Text(
                                    ref.selectedChoise==null?'تخطي':"التالي",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 16.sp,

                                    )),
                                style: TextButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                ),
                                onPressed: () {
                                  if(snapshot.data![tapIndex].isSkipable == 1){
                                    ref.changeIndexn();
                                    print("${ref.selectedChoise }ssssssssssssssssdddddddddddddddddsssssssss");
                                    _updateProgress(context);
                                    controller.nextPage(duration:Duration(milliseconds: 400), curve: Curves.easeIn);
                                    increment(context);
                                  }else if(ref.selectedChoise!=null){
                                    ref.changeIndexn();
                                    print("${ref.selectedChoise }sssssssssssssssssss");
                                    _updateProgress(context);
                                    controller.nextPage(duration:Duration(milliseconds: 400), curve: Curves.easeIn);
                                    increment(context);

                                  }else{
                                    ref.changeIndexn();
                                    print("${ref.selectedChoise }sssssssssssssssssss");
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: orginalRed,
                                      content: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text("برجاء اختيار اجراء")),
                                    ));
                                  }
                                  // if(tapIndex+1 == QuestionManager.len){
                                  //   setState((){
                                  //     level++;
                                  //
                                  //   });
                                  // }
                                },
                              ),
                            ),
                          )):
                      tapIndex+1==QuestionManager.len?
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.5.w,
                                  color: transparnt,
                                ),
                                color: basicPink,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: TextButton(
                                child: Text(
                                    "تأكيد",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 16.sp,

                                    )),
                                style: TextButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                ),
                                onPressed: () {
                                  if(snapshot.data![tapIndex].isSkipable == 1){
                                    ref.changeIndexn();
                                    setState(() {
                                      level++;
                                    });
                                  }else if(ref.selectedChoise!=null){
                                    ref.changeIndexn();
                                    setState(() {
                                      level++;
                                    });
                                  }else{
                                    ref.changeIndexn();
                                    print("${ref.selectedChoise }sssssssssssssssssss");
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: orginalRed,
                                      content: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text("برجاء اختيار اجراء")),
                                    ));
                                  }
                                },
                              ),
                            ),
                          )):
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                                child: Text(
                                    ref.selectedChoise==null?'تخطي':"التالي",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 16.sp,
                                    )),
                                style: TextButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                ),
                                onPressed: () {
                                  if(snapshot.data![tapIndex].isSkipable == 1){
                                    ref.changeIndexn();
                                    _updateProgress(context);
                                    controller.nextPage(duration:Duration(milliseconds: 400), curve: Curves.easeIn);
                                    increment(context);
                                  }else if(ref.selectedChoise!=null){
                                    ref.changeIndexn();
                                    print("${ref.selectedChoise }sssssssssssssssssss");
                                    _updateProgress(context);
                                    controller.nextPage(duration:Duration(milliseconds: 400), curve: Curves.easeIn);
                                    increment(context);
                                  }else{
                                    ref.changeIndexn();
                                    print("${ref.selectedChoise }sssssssssssssssssss");
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: orginalRed,
                                      content: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text("برجاء اختيار اجراء")),
                                    ));
                                  }
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
                                      )),
                                  style: TextButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                  ),
                                  onPressed: () {
                                    _removeProgress(context);
                                    controller.previousPage(duration:Duration(milliseconds: 400), curve: Curves.easeIn);
                                    decrement(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  );
                }
                else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Center(child: CircularProgressIndicator());
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
                            id: widget.id,

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
      ),
    );
  }

  void increment(BuildContext context) {

    Provider.of<InfoProvider>(context, listen: false).myIndexScoial++;
    Provider.of<InfoProvider>(context, listen: false).rebuild();

  }

  void decrement(BuildContext context) {
    Provider.of<InfoProvider>(context, listen: false).myIndexScoial--;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _updateProgress(BuildContext context) {
    Provider.of<InfoProvider>(context, listen: false).religionProgressValue +=
        1 / QuestionManager.len;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _removeProgress(BuildContext context) {
    if (Provider.of<InfoProvider>(context, listen: false)
            .religionProgressValue !=
        (1.0 - (1 / QuestionManager.len))) {
      Provider.of<InfoProvider>(context, listen: false).religionProgressValue -=
          1 / QuestionManager.len;
      Provider.of<InfoProvider>(context, listen: false).rebuild();
    }
  }
}
