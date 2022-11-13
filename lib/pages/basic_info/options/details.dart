import 'dart:io';

import 'package:effah/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../components/reusable_widgets/wait_bottomsheet.dart';
import '../../../components/textfield_details.dart';
import '../../../components/textfield_login.dart';
import '../../../managers/user_manager.dart';
import '../../../models/question_model.dart';
import '../../../models/user_model.dart';
import '../../../modules/basic_info_provider.dart';

class Details extends StatefulWidget {
  Details({Key? key, required this.id, required this.gender}) : super(key: key);
  int? id;
  int? gender;
  static final form = GlobalKey<FormState>();

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _enteredText = '';

  String? txt1, txt2;

  TextEditingController aboutmeController = TextEditingController();

  TextEditingController partenerController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future<MyUser>? details;
    details = getDetails();
    // print("detailsssssss");
    details.then((value) {
      // print(value.about_partner);
      txt1 = value.about_you!;
      txt2 = value.about_partner!;
      if (txt1 != null) {
        aboutmeController.text = txt1!;
      }
      if (txt2 != null) {
        partenerController.text = txt2!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future<bool> _willPopCallback() async {
    //   FocusScope.of(context).unfocus();
    //   return true;
    // }

    double height = MediaQuery.of(context).size.height;

    // details = UserManager().updateUser(id!, gender: gender);
    // print("details");
    // print(details);

    return GestureDetector(
      //onWillPop: _willPopCallback,
      // onWillPop: () {
      //   print("object");
      //
      //   return true;
      // },

      onTap: () {
        // final currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        //   FocusManager.instance.primaryFocus?.unfocus();
        // }
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Form(
              // key: Details.Details.form,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 65.h,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icon/nextto.svg"),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'وصف عني & عن شريك حياتي',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(children: [
                            SvgPicture.asset("assets/icon/10.svg"),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'نبذه عنك',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                          ])),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFieldDetails(
                        hintTxt: 'شاب طموح متدين ',
                        controller: aboutmeController,
                        validator: (k) {
                          // return
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "اكتب نبذه لا تقل عن 50 حرف",
                          style: TextStyle(color: grey, fontSize: 13.sp),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(children: [
                            SvgPicture.asset("assets/icon/13.svg"),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'نبذه عن شريك حياتي',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                          ])),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFieldDetails(
                        hintTxt: 'بنت ملتزمة أخلاقيا و دينيا',
                        controller: partenerController,
                      ),
                      Spacer(),
                      Row(children: [
                        Expanded(
                          child: TextButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text('تأكيد',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16.sp,
                                  )),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: basicPink,
                              // primary: Colors.teal,
                              // onSurface: Colors.yellow,
                              // side: BorderSide(color: Colors.teal, width: 2),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            onPressed: () {
                              if (aboutmeController.text == "" ||
                                  partenerController.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: orginalRed,
                                  content: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                          " من فضلك تأكد من تكملة البيانات")),
                                ));
                              } else {
                                postDetails(aboutmeController.text,
                                    partenerController.text);
                                return;
                              }
                              //  _updateProgress(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             BirthDateInfo(progress: _progressValue)));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15.h,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                //  barrierColor: liGrey.withOpacity(0.8),

                                backgroundColor: transparnt,
                                builder: (context) {
                                  return WaitBottomSheet();
                                });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: ggrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 12.w),
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
                      SizedBox(
                        height: 20.h,
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void postDetails(String you, String partner) async {
    await UserManager()
        .updateUser(widget.id, about_you: you, about_partner: partner);
  }

  Future<MyUser> getDetails() async {
    // MyUser details=
    return await UserManager().updateUser(widget.id, gender: widget.gender);
  }
}
