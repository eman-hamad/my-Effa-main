import 'dart:async';

import 'package:effah/constants.dart';
import 'package:effah/models/questions_model.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:effah/pages/basic_info/options/details.dart';
import 'package:effah/pages/basic_info/options/education.dart';
import 'package:effah/pages/basic_info/options/family.dart';
import 'package:effah/pages/basic_info/options/father_info.dart';
import 'package:effah/pages/basic_info/options/message.dart';
import 'package:effah/pages/basic_info/options/no_notifications.dart';
import 'package:effah/pages/basic_info/options/personal_pic.dart';
import 'package:effah/pages/basic_info/options/diseases.dart';
import 'package:effah/pages/basic_info/options/social/Social_status.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../components/reusable_widgets/wait_bottomsheet.dart';
import '../../../managers/question_manager.dart';
import '../../../modules/basic_info_provider.dart';

import 'myProfile.dart';
import 'confirm_info.dart';
import 'view_my_profile.dart';

class Options extends StatefulWidget {
  Options(
      {Key? key,
      required this.progress,
      required this.id,
      required this.gender})
      : super(key: key);
  late double progress;
  int gender;
  int? id;
  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
//   @override
  bool press = false;

  late bool _loading;

  TextEditingController editingController = TextEditingController();
  Future<Questions>? questions;
  //final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  int? finished1, finished2, finished3, finished4, finished5;
  var items = [];

  // bool visible = false;
  List<String> images = [
    "assets/icon/1.svg",
    "assets/icon/2.svg",
    "assets/icon/3.svg",
    "assets/icon/4.svg",
    "assets/icon/5.svg",
    "assets/icon/6.svg",
    "assets/icon/7.svg",
    "assets/icon/8.svg"
  ];

  List<myclass> nationalites = [
    myclass("مشاهدة حسابي "),
    myclass("البيانات الشخصية & الجسدية"),
    myclass("الدين&الحالةالأجتماعية"),
    myclass("التعليم & العمل"),
    myclass("العائلة"),
    myclass("وصف عني & عن شريكة حياتي"),
    myclass("الصور الشخصية"),
    myclass("تأكيد بياناتي"),
  ];

  late int tapIndex = nationalites.length;

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Message(
                    progress: widget.progress,
                  )));
    });
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pop(context);
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => MyProfile(
    //                 progress: widget.progress,
    //               )));

    // });
  }

  // void _startTimer2() {
  //   Timer(const Duration(seconds: 3), () {
  //     Navigator.pop(context);
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => MyProfile(
  //                   progress: widget.progress,
  //                 )));
  //     Navigator.pop(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<AppStateProvider>(context, listen: false);
    // TextEditingController firstName = TextEditingController();
    // TextEditingController secondName = TextEditingController();
//     print("mmmmmmmmmmmmmmmmmmmmmmmmm");
//     print("widget.id");
//     print(widget.id);
//     print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//     print(Provider.of<InfoProvider>(context, listen: false).progressValue);
//     // questions = isFinished(1);
// // setState(() {

// // });

//     Future<Questions> categorey1 =
//         QuestionManager().isCategoryFinished(widget.id!, 1, widget.gender);
//     categorey1.then((value) {
//       //  setState(() {
//       finished1 = value.is_finish;
//       Provider.of<InfoProvider>(context, listen: false).rebuild();
//       // });
//     });

//     Future<Questions> categorey2 =
//         QuestionManager().isCategoryFinished(widget.id!, 2, widget.gender);
//     categorey2.then((value) {
//       //  setState(() {
//       finished2 = value.is_finish;
//       Provider.of<InfoProvider>(context, listen: false).rebuild();
//       // });
//     });

//     Future<Questions> categorey3 =
//         QuestionManager().isCategoryFinished(widget.id!, 3, widget.gender);
//     categorey3.then((value) {
//       //  setState(() {
//       finished3 = value.is_finish;
//       Provider.of<InfoProvider>(context, listen: false).rebuild();
//       // });
//     });
//     Future<Questions> categorey4 =
//         QuestionManager().isCategoryFinished(widget.id!, 4, widget.gender);
//     categorey4.then((value) {
//       //  setState(() {
//       finished4 = value.is_finish;
//       Provider.of<InfoProvider>(context, listen: false).rebuild();
//       // });
//     });

//     Future<Questions> categorey5 =
//         QuestionManager().isCategoryFinished(widget.id!, 5, widget.gender);
//     categorey5.then((value) {
//       //  setState(() {
//       finished5 = value.is_finish;
//       Provider.of<InfoProvider>(context, listen: false).rebuild();
//       // });
//     });
    // isFinished(1).then((value) {
    //   print("value");
    //   print(value.is_finish);
    //   setState(() {
    //     finished1 = value.is_finish;
    //   });
    // });
    // isFinished(2).then((value) {
    //   print("value");
    //   print(value.is_finish);
    //   setState(() {
    //     finished2 = value.is_finish;
    //   });
    // });
    // isFinished(3).then((value) {
    //   print("value");
    //   print(value.is_finish);
    //   setState(() {
    //     finished3 = value.is_finish;
    //   });
    // });
    // isFinished(4).then((value) {
    //   print("value");
    //   print(value.is_finish);
    //   setState(() {
    //     finished4 = value.is_finish;
    //   });
    // });
    // isFinished(5).then((value) {
    //   print("value");
    //   print(value.is_finish);
    //   setState(() {
    //     finished5 = value.is_finish;
    //   });
    // });
    print("finished");
    print(finished3);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: transparnt,
      // ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 65.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: SvgPicture.asset(
            "assets/image/logo.svg",
            width: 99.13.w,
            // // height: 60.h,
            // fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 5.h),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: llgrey, width: 1.w),
              borderRadius: BorderRadius.circular(15),
            ),
            color: white,
            child: Padding(
              padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 30.h),
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 13.h),
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final boxWidth = constraints.constrainWidth();
                            final dashWidth = 6.0;
                            final dashHeight = 0.9;
                            final dashCount =
                                (boxWidth / (2 * dashWidth)).floor();
                            return Flex(
                              children: List.generate(dashCount, (_) {
                                return SizedBox(
                                  width: dashWidth,
                                  height: dashHeight,
                                  child: const DecoratedBox(
                                    decoration: BoxDecoration(color: gseparate),
                                  ),
                                );
                              }),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                            );
                          },
                        ),
                      ),
                  shrinkWrap: true,
                  itemCount: nationalites.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        tapIndex = index;
                        // _setIconVisible(visible);
                        // print("before");
                        // print(visible);
                        // visible = !visible;
                        press = !press;
                        // print("after");
                        // print(visible);
                        setState(() {});
                        // press = false;
                        // visible = false;
                        if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SocialStatus(
                                        gender: widget.gender,
                                        id: widget.id,
                                        progress: widget.progress,
                                      )));
                        } else if (index == 0) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MyProfile(
                          //               progress: progress,
                          //             )));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewMyProfile(
                                      //progress: progress,
                                      )));
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Diseases(
                                        gender: widget.gender,
                                        id: widget.id!,
                                        progress: widget.progress,
                                      )));
                        } else if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Education(
                                        gender: widget.gender,
                                        id: widget.id!,
                                        progress: widget.progress,
                                      )));
                        } else if (index == 4) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Family(
                                        gender: widget.gender,
                                        id: widget.id!,
                                        progress: widget.progress,
                                      )));
                        } else if (index == 7) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmInfo(
                                        id: widget.id,
                                        gender: widget.gender,
                                        progress: widget.progress,
                                      )));
                        } else if (index == 6) {
                          widget.gender == 1
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PersonalPic(
                                            id: widget.id,
                                            gender: widget.gender,
                                            progress: widget.progress,
                                          )))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FatherInfo(
                                            gender: widget.gender,
                                            id: widget.id,
                                            progress: widget.progress,
                                          )));
                        } else if (index == 5) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                        id: widget.id,
                                        gender: widget.gender,
                                      )));
                        }
                      },
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            // ListTile(
                            //   title: Text('${nationalites[index].word} '),
                            // ),

                            // ImageIcon(
                            SvgPicture.asset(images[index]),
                            //   size: 40,
                            //   color: basicPink,
                            // ),
                            SizedBox(
                              width: 7.w,
                            ),
                            Text(
                              index == 6 && widget.gender == 2
                                  ? "بيانات ولي الامر"
                                  : '${nationalites[index].word} ',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color:
                                      //tapIndex == index && press == false

                                      (index == 6 &&
                                                  widget.gender == 2 &&
                                                  finished5 == 1) ||
                                              (index == 3 && finished3 == 1) ||
                                              (index == 4 && finished4 == 1) ||
                                              (index == 2 && finished2 == 1) ||
                                              (index == 1 && finished1 == 1)
                                          ? basicPink
                                          : black),
                            ),
                            const Spacer(),
                            // Visibility(
                            //   visible:
                            //       tapIndex == index && press == false
                            //           ? true
                            //           : false,
                            //   child: const Icon(
                            //     Icons.check,
                            //     size: 30,
                            //     color: basicPink,
                            //   ),
                            // ),

                            Icon(
                              Icons.check,
                              size: 30,
                              color:
                                  //tapIndex == index && press == false
                                  
                                      (index == 6 &&
                                                  widget.gender == 2 &&
                                                  finished5 == 1) ||
                                              (index == 3 && finished3 == 1) ||
                                              (index == 4 && finished4 == 1) ||
                                              (index == 2 && finished2 == 1) ||
                                              (index == 1 && finished1 == 1)
                                      ? basicPink
                                      : transparnt,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
        // SizedBox(
        //   height: 5.h,
        // ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        colors: [mdGrey, basicPink], stops: [0.60, 0.40])),
                child: TextButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text('تسجيل الحساب',
                        style: TextStyle(
                          color: white,
                          fontSize: 16.sp,
                          // fontWeight: FontWeight.w500
                        )),
                  ),
                  style: TextButton.styleFrom(
                    // backgroundColor: const Color(0xffff8297),
                    // primary: Colors.teal,
                    // onSurface: Colors.yellow,
                    // side: BorderSide(color: Colors.teal, width: 2),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    // _updateProgress(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             Message()));
                    // WillPopScope(
                    //   onWillPop: ,
                    //////////

                    //or for men
                    // showModalBottomSheet(
                    //     context: context,
                    //     barrierColor: liGrey.withOpacity(0.8),
                    //     // shape: RoundedRectangleBorder(
                    //     //   borderRadius: BorderRadius.circular(24),
                    //     // ),
                    //     backgroundColor: transparnt,
                    //     //clipBehavior: Clip.antiAliasWithSaveLayer,
                    //     builder: (context) {
                    //       return Padding(
                    //           padding:
                    //               EdgeInsets.symmetric(horizontal: 10.w),
                    //           child: Card(
                    //             color: white,
                    //             elevation: 6,
                    //             shadowColor: black,
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(15.0),
                    //             ),
                    //             child: Padding(
                    //               padding: EdgeInsets.symmetric(
                    //                   // vertical: 10.h,
                    //                   horizontal: 20.w),
                    //               child: Column(children: [
                    //                 // ImageIcon(
                    //                 Image.asset(
                    //                   "assets/image/messagee.png",
                    //                   width: 295.86.w,
                    //                   // height: 100.h,
                    //                 ),
                    //                 //   color: Color(0xffFF8297),
                    //                 //   // size: 150,
                    //                 // ),
                    //                 Padding(
                    //                   padding: EdgeInsets.symmetric(
                    //                       vertical: 20.0.h),
                    //                   child: Text(
                    //                     "تم الأرسال",
                    //                     style: TextStyle(
                    //                         color: basicPink,
                    //                         fontSize: 20.sp,
                    //                         fontWeight: FontWeight.bold),
                    //                   ),
                    //                 ),
                    //                 Directionality(
                    //                   textDirection: TextDirection.rtl,
                    //                   child: Padding(
                    //                     padding:
                    //                         EdgeInsets.only(bottom: 10.h),
                    //                     child: Text(
                    //                       "في انتظار مراجعة الحساب الخاص بك برجاء الانتظار حتي يتم الانتهاء",
                    //                       style: TextStyle(fontSize: 16.sp),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: EdgeInsets.only(
                    //                       top: 10.h, bottom: 10.h),
                    //                   child: Text(
                    //                     "يمكنك التواصل من خلال",
                    //                     style: TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 16.sp),
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: EdgeInsets.only(
                    //                       top: 10.h, bottom: 10.h),
                    //                   child: Row(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.center,
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     children: [
                    //                       // ImageIcon(
                    //                       Image.asset(
                    //                         "assets/icon/icon1.png",
                    //                         width: 36.w,
                    //                         height: 36.h,
                    //                       ),

                    //                       // size: 150,
                    //                       // ),
                    //                       SizedBox(
                    //                         width: 2.w,
                    //                       ),
                    //                       // ImageIcon(
                    //                       Image.asset(
                    //                         "assets/icon/icon2.png",
                    //                         width: 36.w,
                    //                         height: 36.h,
                    //                       ),

                    //                       // size: 150,
                    //                       // ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 25.h,
                    //                 ),
                    //                 Text(
                    //                   " * عادة مايتم المراجعة خلال 24 ساعة من فضلك كن صبورا  *",
                    //                   style: TextStyle(
                    //                       color: gmGrey, fontSize: 11.sp),
                    //                 )
                    //               ]),
                    //             ),
                    //           ));
                    //     });
                    //////////////////////////////////////
                    // _startTimer();
                    //////////////////////////////////
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Message(
                                  progress: widget.progress,
                                )));
                    //_startTimer2();

                    //for girls

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => MyProfile(
                    //               progress: widget.progress,
                    //             )));
                  },
                ),
              ),
            ),
            SizedBox(
              width: 15.h,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    //barrierColor: liGrey.withOpacity(0.8),
                    backgroundColor: transparnt,
                    builder: (context) {
                      return WaitBottomSheet();
                    });
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: ggrey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
                  child: SvgPicture.asset(
                      // AssetImage(
                      "assets/icon/9.svg"),
                ),
                //   size: 50,
                //   color: white,
                // ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 20.h,
        )
      ]),
    );
  }

  // isFinished(int c_id) {
  //   return QuestionManager()
  //       .isCategoryFinished(widget.id!, c_id, widget.gender);
  // }

  // void _setIconVisible(bool v) {
  Widget item(i, nationalites) => Row(
        children: [
          // ListTile(
          //   title: Text('${nationalites[i].word} '),
          // ),
          Container(
              child: IconButton(
                  iconSize: 30,
                  hoverColor: basicPink,
                  onPressed: () {},
                  icon: (const Icon(Icons.check))))
        ],
      );
}

class myclass {
  String word;

  myclass(this.word);
}
