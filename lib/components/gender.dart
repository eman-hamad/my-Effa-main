import 'package:effah/constants.dart';
import 'package:effah/models/controller_reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../modules/basic_info_provider.dart';

class Gender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            'ما هو نوع المستخدم',
            style: TextStyle(fontSize: 20.sp),
          ),
        )),
        Padding(
          padding: EdgeInsets.only(
            top: 20.0.h,
            // right: 15.w, left: 15.w
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final ref =
                        Provider.of<ControllerReg>(context, listen: false);
                    Provider.of<InfoProvider>(context, listen: false).isFemale =
                        true;

                    Provider.of<InfoProvider>(context, listen: false).loading =
                        !Provider.of<InfoProvider>(context, listen: false)
                            .loading;
                    Provider.of<InfoProvider>(context, listen: false).rebuild();
                    _updateProgress(context);
                    // postGender(2, context);
                    ref.onTap(0.25);
                    ControllerReg.gender = 2;
                    print("ControllerReg.gender ");
                    print(ControllerReg.gender);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Provider.of<InfoProvider>(context).isFemale
                            ? basicPink
                            : grey,
                        width: 1.3.w,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      // color: Provider.of<InfoProvider>(context).isMale
                      //     ? white
                      //     : basicPink,
                    ),
                    elevation:
                        Provider.of<InfoProvider>(context).isFemale ? 15 : 0,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image(
                            SvgPicture.asset('assets/image/female.svg'),
                            //   height: 64.h,
                            //   width: 64.w,
                            // ),
                            SizedBox(
                              height: 15.0.h,
                            ),
                            Text(
                              'أنثي',
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0.w,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final ref =
                        Provider.of<ControllerReg>(context, listen: false);
                    Provider.of<InfoProvider>(context, listen: false).pressed1 =
                        true;

                    Provider.of<InfoProvider>(context, listen: false).isFemale =
                        false;

                    Provider.of<InfoProvider>(context, listen: false).loading =
                        !Provider.of<InfoProvider>(context, listen: false)
                            .loading;
                    Provider.of<InfoProvider>(context, listen: false).rebuild();
                    _updateProgress(context);
                    ref.onTap(0.25);
                    // postGender(1, context);
                    ControllerReg.gender = 1;
                    print("ControllerReg.gender ");
                    print(ControllerReg.gender);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Provider.of<InfoProvider>(context,
                                          listen: false)
                                      .pressed1 &&
                                  !Provider.of<InfoProvider>(context).isFemale
                              ? basicPink
                              : grey,
                          width: 1.3.w,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      // color: Provider.of<InfoProvider>(context).isMale
                      //     ? basicPink
                      //     : white,
                    ),
                    elevation: Provider.of<InfoProvider>(context, listen: false)
                                .pressed1 &&
                            !Provider.of<InfoProvider>(context).isFemale
                        ? 15
                        : 0,
                    shadowColor: grey,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image(
                            SvgPicture.asset('assets/image/male.svg'),
                            //   height: 64.h,
                            //   width: 64.w,
                            // ),
                            SizedBox(
                              height: 15.0.h,
                            ),
                            Text(
                              'ذكر',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // void postGender(
  //   int gend,
  //   BuildContext context,
  // ) async {
  //   //final MyUser user = await UserManager().updateUser(id, gender: gend);
  //   //  if (user.gender != 0) {
  //   // Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(
  //   //         builder: (context) =>
  //   // Navigator.push(context, PageRouteBuilder(pageBuilder:
  //   //     (BuildContext context, Animation<double> animation,
  //   //         Animation<double> secondaryAnimation) {
  //   //   return NamingInfo(
  //   //       gender: user.gender,
  //   //       id: widget.id,
  //   //       progress: Provider.of<InfoProvider>(context, listen: false)
  //   //           .progressValue);
  //   // }));
  //   // Provider.of<InfoProvider>(context, listen: false).index = 1;
  //   // Provider.of<InfoProvider>(context, listen: false).rebuild();
  //   //}
  // }
  void _updateProgress(BuildContext context) {
    //  Provider.of<InfoProvider>(context, listen: false).updateProgress();
    Provider.of<InfoProvider>(context, listen: false).progressValue += 0.15;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }
}
