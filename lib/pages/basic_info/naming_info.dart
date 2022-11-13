import 'package:effah/components/reusable_widgets/rounded_button.dart';
import 'package:effah/constants.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../managers/user_manager.dart';
import '../../models/user_model.dart';
import '../../modules/basic_info_provider.dart';
import 'birthdate_info.dart';

class NamingInfo extends StatelessWidget {
  NamingInfo({Key? key, required this.progress, this.id , required this.gender}) : super(key: key);
  late double progress;
  late double _progressValue = progress;
  final int? id;
  int ?gender;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<AppStateProvider>(context, listen: false);
    

    Future<bool> _onWillPop() async {
      // return false; //<-- SEE HERE
      _removeProgress(context);
      return true;
    }

    print(Provider.of<InfoProvider>(context, listen: false).progressValue);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0.0,
        //   backgroundColor: transparnt,
        // ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(children: [
            SizedBox(
              height: 65.h,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              // alignment: Alignment.centerRight,
              child: Row(children: [
                // ImageIcon(
                SvgPicture.asset("assets/icon/nextto.svg"),
                //   size: 50,
                //   color: basicPink,
                // ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'البيانات الأساسية',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  //  left: 10.w, right: 10.w,
                  bottom: 45.h,
                  top: 20.h),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: LinearProgressIndicator(
                        minHeight: 9.h,
                        backgroundColor: bgrey,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(basicPink),
                        value: Provider.of<InfoProvider>(context, listen: false)
                            .progressValue,
                      ),
                    )),
              ),
            ),
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
                          controller: secondName,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[\u0621-\u064A]'))
                          ],
                          // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('/[\u0600-\u06FF]/'))],
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
                          controller: firstName,
                          cursorColor: basicPink,
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "ادخل الاسم الأول";
                            } else if (text.length < 2) {
                              return 'علي الأقل حرفين';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[\u0621-\u064A]'))
                          ],
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
            const Expanded(flex: 4, child: SizedBox()),
            SizedBox(
              //width: double.infinity,
              width: 264.w,
              //height: 44.h,
              child: RoundedButton(
                  mywidget: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: const Text('التالي',
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
                    postName(firstName.text, secondName.text,context);

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
              flex: 2,
              child: SizedBox(
                  // height: 10,
                  ),
            )
          ]),
        ),
      ),
    );
  }

  void postName(String fname, String lname, BuildContext context,) async {
    final MyUser user =
    await UserManager().updateUser(id, frName: fname, lsName: lname);
    if(user.faName!=null){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BirthDateInfo(
                  gender: gender!,
                  id: id,
                  progress: Provider.of<InfoProvider>(context,
                      listen: false)
                      .progressValue)));
    }
  }

  // void _updateProgress(BuildContext context) {
  //   _progressValue += 0.1;
  //   Provider.of<InfoProvider>(context, listen: false).rebuild();
  // }

  void _updateProgress(BuildContext context) {
    //Provider.of<InfoProvider>(context, listen: false).updateProgress(_progressValue);
    Provider.of<InfoProvider>(context, listen: false).progressValue += 0.15;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _removeProgress(BuildContext context) {
    // Provider.of<InfoProvider>(context, listen: false).removeProgress(_progressValue);
    Provider.of<InfoProvider>(context, listen: false).progressValue = 0.25;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }
}
