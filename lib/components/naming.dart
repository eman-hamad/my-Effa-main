import 'package:effah/components/reusable_widgets/rounded_button.dart';
import 'package:effah/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../managers/user_manager.dart';
import '../models/user_model.dart';
import '../modules/basic_info_provider.dart';

class Naming extends StatelessWidget {
 
  
  GlobalKey<FormState> form = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();

  TextEditingController secondName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("index");
  //  print(Provider.of<InfoProvider>(context, listen: false).index);
    return Expanded(
      child: Column(
        children: [
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              'اسمك ؟',
              style: TextStyle(fontSize: 20.sp),
            ),
          )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0.h),
            child: Form(
              key: form,
              child: Row(
                // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onTap: () {
                          if (secondName.selection ==
                              TextSelection.fromPosition(TextPosition(
                                  offset: secondName.text.length - 1))) {
                            //setState(() {
                            secondName.selection = TextSelection.fromPosition(
                                TextPosition(offset: secondName.text.length));
                            Provider.of<InfoProvider>(context, listen: false)
                                .rebuild();
                            //  });
                          }
                        },
                        controller: secondName,
                        textAlign: TextAlign.right,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(
                        //       RegExp('[\u0621-\u064A]'))
                        // ],
                        cursorColor: basicPink,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return " ادخل الاسم الأخير ";
                          } else if (text.length < 2) {
                            return 'علي الأقل حرفين';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (String value) {},
                        onChanged: (String value) {},
                        maxLength: 12,
                        decoration: InputDecoration(
                          labelText: 'الاسم الأخير',
                          labelStyle: TextStyle(fontSize: 14.sp),
                          floatingLabelStyle: TextStyle(
                            color: basicPink,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: basicPink, width: 1.5.w),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onTap: () {
                          if (firstName.selection ==
                              TextSelection.fromPosition(TextPosition(
                                  offset: firstName.text.length - 1))) {
                            // setState(() {
                            firstName.selection = TextSelection.fromPosition(
                                TextPosition(offset: firstName.text.length));

                            Provider.of<InfoProvider>(context, listen: false)
                                .rebuild();
                            //  });
                          }
                        },
                        controller: firstName,
                        // //
                        // textAlign: TextAlign.right,
                        cursorColor: basicPink,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "ادخل الاسم الأول";
                          } else if (text.length < 2) {
                            return 'علي الأقل حرفين';
                          }
                          return null;
                        },
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(
                        //       RegExp('[\u0621-\u064A]'))
                        // ],
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (String value) {},
                        onChanged: (String value) {},
                        maxLength: 12,
                        decoration: InputDecoration(
                          labelText: 'الاسم الأول',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: basicPink, width: 1.5.w),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusColor: basicPink,
                          floatingLabelStyle: TextStyle(
                            color: basicPink,
                          ),
                          labelStyle: TextStyle(fontSize: 14.sp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Spacer(),
          const Expanded(flex: 3, child: SizedBox()),
          SizedBox(
            //width: double.infinity,
            width: 264.w,
            //height: 44.h,
            child: RoundedButton(
                mywidget: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Text('التالي',
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                        //fontWeight: FontWeight.w500
                      )),
                ),
                raduis: 10,
                myfun: () {
                  _updateProgress(context);

                  if (!form.currentState!.validate()) {
                    return;
                  }
                  postName(firstName.text, secondName.text, context);
                },
                color: basicPink),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 50),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: TextButton(
          //       child: const Text('التالي',
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               fontWeight: FontWeight.w500)),
          //       style: TextButton.styleFrom(
          //         backgroundColor: const Color(0xffff8297),
          //         // primary: Colors.teal,
          //         // onSurface: Colors.yellow,
          //         // side: BorderSide(color: Colors.teal, width: 2),
          //         shape: const RoundedRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10))),
          //       ),
          //       onPressed: () {
          //         _updateProgress(context);
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) =>
          //                     BirthDateInfo(progress: _progressValue)));
          //       },
          //     ),
          //   ),
          // ),
          const Expanded(
            flex: 1,
            child: SizedBox(
                // height: 10,
                ),
          )
        ],
      ),
    );
  }

  void postName(
    String fname,
    String lname,
    BuildContext context,
  ) async {
    // final MyUser user =
    //     await UserManager().updateUser(id, frName: fname, lsName: lname);
    // if(user.faName!=null){
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    // Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,
    //     Animation<double> animation, Animation<double> secondaryAnimation) {
    //   return BirthDateInfo(
    //       gender: widget.gender!,
    //       id: widget.id,
    //       progress:
    //           Provider.of<InfoProvider>(context, listen: false).progressValue);
    // }));
    // }
    //Provider.of<InfoProvider>(context, listen: false).index = 2;
    //Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _updateProgress(BuildContext context) {
    //  Provider.of<InfoProvider>(context, listen: false).updateProgress();
    Provider.of<InfoProvider>(context, listen: false).progressValue += 0.15;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }
}
