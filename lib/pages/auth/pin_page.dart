import 'dart:async';

import 'package:effah/constants.dart';
import 'package:effah/managers/user_manager.dart';
import 'package:effah/models/user_model.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:effah/pages/basic_info/options/options.dart';
import 'package:effah/pages/complate_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../components/reusable_widgets/rounded_button.dart';
import '../../preferences/preferences.dart';
import 'CodeInput.dart';

class PinPage extends StatefulWidget {
  const PinPage({Key? key, this.name, this.code, this.myPhone})
      : super(key: key);
  final String? name;
  final String? code;
  final String? myPhone;
  // final int id;
  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  // late Future<User> user;
  // int? myId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("code");
    print(widget.code);
    print(widget.myPhone);
    verifyPhone();
  }

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  // var size;
  FocusNode _focusDigit1 = FocusNode();
  FocusNode _focusDigit2 = FocusNode();
  FocusNode _focusDigit3 = FocusNode();
  FocusNode _focusDigit4 = FocusNode();
  FocusNode _focusDigit5 = FocusNode();
  FocusNode _focusDigit6 = FocusNode();

  TextEditingController codeController1 = TextEditingController();
  TextEditingController codeController2 = TextEditingController();
  TextEditingController codeController3 = TextEditingController();
  TextEditingController codeController4 = TextEditingController();
  TextEditingController codeController5 = TextEditingController();
  TextEditingController codeController6 = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";
  String? code;
  @override
  void dispose() {
    super.dispose();
    _focusDigit1.dispose();
    _focusDigit2.dispose();
    _focusDigit3.dispose();
    _focusDigit4.dispose();
    _focusDigit5.dispose();
    _focusDigit6.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<AppStateProvider>(context, listen: false);
    double height = MediaQuery.of(context).size.height;

    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    print("wowwww");
    print(widget.code);
    print(widget.name);
    print(widget.myPhone);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        //WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Form(
              child: Column(

                  // mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Spacer(),
                    SizedBox(
                      height: 29.h,
                    ),
                    SvgPicture.asset(
                      'assets/image/code_top.svg',
                      width: MediaQuery.of(context).size.width,

                      //  height: height*0.2,
                      // width: 45,
                      // width: double.infinity,
                      // height: 137.48.h,

                      // width: 375.w,
                      fit: BoxFit.fill,
                    ),
                    // SizedBox(
                    //   height: height * 0.03,
                    // ),

                    Padding(
                      padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
                      child: SvgPicture.asset(
                        'assets/image/code_center.svg',
                        fit: BoxFit.cover,
                      ),
                    ),

                    Text(
                      "من فضلك ادخل كود التفعيل المرسل الي",
                      style: TextStyle(
                        // fontFamily: 'JFFlat',

                        fontSize: 14.sp,

                        color: black,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      " ${widget.code} " " ${widget.myPhone}",
                      style: TextStyle(
                        // fontFamily: 'JF Flat',

                        fontSize: 14.sp,

                        color: basicPink,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(
                    //   height: height * 0.05,
                    // ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            // 8.w
                            MediaQuery.of(context).size.width * 0.12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CodeInput(
                            focusNode0: _focusDigit1,
                            controller: codeController1,
                          ),
                          SizedBox(
                            width: 12.w,
                            //MediaQuery.of(context).size.width * 0.063,
                          ),
                          CodeInput(
                            focusNode0: _focusDigit2,
                            controller: codeController2,
                          ),
                          SizedBox(
                            width: 12.w,
                            // MediaQuery.of(context).size.width * 0.063,
                          ),
                          CodeInput(
                            focusNode0: _focusDigit3,
                            controller: codeController3,
                          ),
                          SizedBox(
                            width: 12.w,
                            // MediaQuery.of(context).size.width * 0.063,
                          ),
                          CodeInput(
                            focusNode0: _focusDigit4,
                            controller: codeController4,
                          ),
                          SizedBox(
                            width: 12.w,
                            //MediaQuery.of(context).size.width * 0.063,
                          ),
                          CodeInput(
                            focusNode0: _focusDigit5,
                            controller: codeController5,
                          ),
                          SizedBox(
                            width: 12.w,
                            //MediaQuery.of(context).size.width * 0.063,
                          ),
                          CodeInput(
                            focusNode0: _focusDigit6,
                            controller: codeController6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            // 14.w
                            MediaQuery.of(context).size.width * 0.12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$minutes : $seconds',

                            style: TextStyle(
                              // fontFamily: 'JF Flat',

                              fontSize: 14.sp,

                              color: basicPink,
                            ),

                            // textAlign: TextAlign.right,
                          ),
                          // Expanded(
                          //     child: SizedBox(
                          //   width: width * 0.03,
                          // )),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              if (minutes == "00" && seconds == "00") {
                                verifyPhone();
                              }
                              //verifyPhone();
                              else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: orginalRed,
                                  content: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                          "من فضلك انتظر دقيقة ثم حاول مرة أخري")),
                                ));
                              }
                            },
                            child: Text(
                              'إعادة ارسال الكود',

                              style: TextStyle(
                                // fontFamily: 'JF Flat',

                                fontSize: 14.sp,

                                color: black,
                              ),

                              // textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(

                    SizedBox(
                      height: 60.h,
                    ),
                    SizedBox(
                      width: 148.w,
                      height: 44.w,
                      child: RoundedButton(
                        color: basicPink,
                        mywidget: Text('تأكيد',
                            style: TextStyle(
                                color: white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500)),
                        raduis: 10,
                        myfun: () async {
                          code = codeController1.text.trim() +
                              codeController2.text.trim() +
                              codeController3.text.trim() +
                              codeController4.text.trim() +
                              codeController5.text.trim() +
                              codeController6.text.trim();
                          print("coooooode");
                          print(code);

                          signIn();
                        },
                      ),
                    ),
                    Spacer()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void verifyPhone() async {
    print("full phone");
    print("${widget.code}${widget.myPhone}");
    await auth.verifyPhoneNumber(
      timeout: const Duration(minutes: 2),
      phoneNumber: "${widget.code}${widget.myPhone}",
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        print("faillll");
        print(e.message);
        print(e.code);
        switch (e.code) {
          case "invalid-verification-code":
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: orginalRed,
              content: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("الكود غير صحيح")),
            ));
            break;

          case "invalid-phone-number":
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: orginalRed,
              content: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("  رقم التليفون الذي أدخلته غير صحيح")),
            ));
            break;

          case "too-many-requests":
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: orginalRed,
              content: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("من فضلك حاول مرة أخري في وقت لاحق")),
            ));
            break;

          default:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: orginalRed,
              content: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("${e.code} " " ${e.message}")),
            ));
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;

        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: basicPink,
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text("من فضلك ادخل الكود الذي تم ارساله اليك")),
        ));
        myDuration = const Duration(seconds: 60);
        startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void signIn() async {
    print("verificationID");
    print(verificationID);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: code!);
    try {
      await auth.signInWithCredential(credential).then((value) async {
        print("You are logged in successfullyl");

        final MyUser user = await UserManager()
            .postUser(widget.myPhone, widget.code, widget.name);
        print("user");
        print(user.isNew);
        if (user.isNew == 0) {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          Navigator.push(context, PageRouteBuilder(pageBuilder:
              (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
            return ComplateInfo(
              id: user.id,
            );
          }));
        } else {
          // Preferences.instance.setUser(user).whenComplete(() =>

          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return Options(
                    gender: user.gender!,
                    id: user.id,
                    progress: 0,
                  );
                },
                transitionDuration: Duration.zero,
              ));
          //);
          //  Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Options(
          //               gender: user.gender!,
          //               id: user.id,
          //               progress: 0,
          //             ))));
        }
        // if(user.isNew == 1){

        //    Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => ComplateInfo()));

        // }
        // else if(user.isNew == 0){
        //    Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => Options(progress: 0.0,)));

        // }
////////////////
        //   Fluttertoast.showToast(
        //       msg: "You are logged in successfully",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        //   Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (context) => Home()));
      });

      // ...
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print("e.message");
      print(e.code);
      switch (e.code) {
        case "invalid-verification-id":
          print("objecttttttt");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: orginalRed,
            content: Directionality(
                textDirection: TextDirection.rtl,
                child: Text("الكود غير صحيح")),
          ));

          break;

        case "invalid-verification-code":
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: orginalRed,
            content: Directionality(
                textDirection: TextDirection.rtl,
                child: Text("الكود غير صحيح")),
          ));

          break;

        case "invalid-phone-number":
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: orginalRed,
            content: Directionality(
                textDirection: TextDirection.rtl,
                child: Text("  رقم التليفون الذي أدخلته غير صحيح")),
          ));
          break;

        case "session-expired":
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: orginalRed,
            content: Directionality(
                textDirection: TextDirection.rtl,
                child:
                    Text("من فضلك اضغط اعادة ارسال الكود وأدخل الكود الجديد")),
          ));
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: orginalRed,
        content: Directionality(
            textDirection: TextDirection.rtl, child: Text(e.toString())),
      ));
    }
  }
}
