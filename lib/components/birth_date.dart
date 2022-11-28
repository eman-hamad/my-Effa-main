import 'package:effah/components/reusable_widgets/rounded_button.dart';
import 'package:effah/constants.dart';
import 'package:effah/models/controller_reg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../managers/user_manager.dart';
import '../models/user_model.dart';
import '../modules/basic_info_provider.dart';

class BirthDate extends StatelessWidget {
  
   DateTime myDate = DateTime(2002);
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              'تاريخ ميلادك ؟',
              style: TextStyle(fontSize: 20.sp),
            ),
          )),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 18.0.h,
                //left: 15.w, right: 15.w
              ),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: llgrey, width: 1.w),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  //color: Colors.black12,
                  // width: MediaQuery.of(context).size.width * .8,
                  // height: MediaQuery.of(context).size.height / 7,
                  child: CupertinoDatePicker(
                    // backgroundColor: Colors.amber,
                    dateOrder: DatePickerDateOrder.mdy,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: myDate,
                    minimumYear: 1960,
                    minimumDate: DateTime(1960, 12, 31),
                    // maximumYear: 2002,
                    maximumDate: DateTime(2002, 12, 31),
    
                    onDateTimeChanged: (dateTime) {
                      myDate = dateTime == null ? myDate : dateTime;
    
                      debugPrint("$dateTime");
                    },
                  ),
                ),
              ),
            ),
          ),
    
          // const Expanded( child: SizedBox()),
    
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SizedBox(
              // width: double.infinity,
              width: 264.w,
              //height: 44.h,
              child: RoundedButton(
                  mywidget: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: Text('التالي',
                        style: TextStyle(
                          color: white,
                          fontSize: 16.sp,
                          // fontWeight: FontWeight.w500
                        )),
                  ),
                  raduis: 10,
                  myfun: () {
                    final ref = Provider.of<ControllerReg>(context,listen: false);
                    // print("object");
                    // print(myDate);
                    _updateProgress(context);
                    postBirthDate(myDate.toString(), context);
                    ref.onTap(0.74);
                  },
                  color: basicPink),
            ),
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
          //                     NationalityInfo(progress: _progressValue)));
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
    );
   
  }

void postBirthDate(String? birthDate, BuildContext context) async {
    // final MyUser user =
    //     await UserManager().updateUser(id, birth_date: birthDate);
    // if (user.birthDate != null) {
    //   // Navigator.push(
    //   //     context,
    //   //     MaterialPageRoute(
    //   //         builder: (context) =>
    //   Navigator.push(context, PageRouteBuilder(pageBuilder:
    //       (BuildContext context, Animation<double> animation,
    //           Animation<double> secondaryAnimation) {
    //     return NationalityInfo(
    //         gender: gender, progress: _progressValue, id: id);
    //   }));
    // }
    // Provider.of<InfoProvider>(context, listen: false).index = 3;
    // Provider.of<InfoProvider>(context, listen: false).rebuild();
  }


void _updateProgress(BuildContext context) {
  //  Provider.of<InfoProvider>(context, listen: false).updateProgress();
  Provider.of<InfoProvider>(context, listen: false).progressValue += 0.15;
  Provider.of<InfoProvider>(context, listen: false).rebuild();
}
}