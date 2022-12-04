import 'dart:async';

import 'package:effah/pages/basic_info/options/myProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import '../pages/basic_info/options/bottom_tabs/filter/filter.dart';
import '../pages/basic_info/options/bottom_tabs/my_account/my_account.dart';
import '../pages/basic_info/options/bottom_tabs/settings/settings.dart';
import '../pages/basic_info/options/notifications.dart';

class NoNotifications extends StatelessWidget {
  const NoNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, left: 25.w, right: 20.w),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(children: [
          Image.asset(
            "assets/image/nonotify.png",
            fit: BoxFit.cover,
            // height: 278.32.h,
            // width: double.infinity,
          ),
          Text(
            "يتم الان عرض حسابك علي المستخدمين . سيصلك اشعار عندما يرسل احدهم طلب لكي ",
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              "يمكنك استخدام الفلتر لتحديد من يمكنه ارسال طلبات.",
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
          ),
          Container(
              width: 165.w,
              //height: 54.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: transparnt,
                  border: Border.all(
                    color: basicPink,
                    width: 2.w,
                  )),
              child: TextButton(
                onPressed: () {
                  // Navigator.pop(
                  //     context);
                  //                Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  //     builder: (context) =>   Filter()));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("الفلتر",
                            style:
                                TextStyle(color: basicPink, fontSize: 14.sp)),
                        SizedBox(
                          width: 5.w,
                        ),
                        Image.asset(
                          "assets/icon/tab3.png",
                          color: basicPink,
                        ),
                        // size: 30,
                      ]),
                ),
              )),
        ]),
      ),
    );
  }
}
