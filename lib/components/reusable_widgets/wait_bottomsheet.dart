import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';


class WaitBottomSheet  extends StatelessWidget {
  const WaitBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
                           Column(
                             children: [
                               Expanded(
                                 
                                  child: Card(
                                    color: white,
                                    elevation: 6,
                                    shadowColor: black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        // ImageIcon(
                                      
                                        //   color: Color(0xffFF8297),
                                        //   // size: 150,
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.0.h),
                                          child: Text(
                                            "في انتظار",
                                            style: TextStyle(
                                                color: basicPink,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10.h),
                                            child: Text(
                                           "اكمال بيانات الحساب الخاص بك برجاء الانتظار حتي يتم الانتهاء",
                                              style: TextStyle(fontSize: 16.sp),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                       
                                      ]),
                                    ),
                                  )),
                             ],
                           );
                    
  }
}