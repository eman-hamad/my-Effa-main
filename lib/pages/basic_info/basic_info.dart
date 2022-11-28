import 'package:effah/components/birth_date.dart';
import 'package:effah/components/custom_page_view.dart';
import 'package:effah/components/gender.dart';
import 'package:effah/components/naming.dart';
import 'package:effah/components/nationality_info.dart';
import 'package:effah/components/religion.dart';
import 'package:effah/constants.dart';
import 'package:effah/models/controller_reg.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../components/reusable_widgets/rounded_button.dart';
import '../../managers/user_manager.dart';
import '../../models/user_model.dart';
import '../../modules/basic_info_provider.dart';

class BasicInfo extends StatelessWidget {
  BasicInfo({Key? key, this.id}) : super(key: key);
  final int? id;

  DateTime myDate = DateTime(2002);
  @override
  Widget build(BuildContext context) {
    //final model = Provider.of<AppStateProvider>(context, listen: false);

    Future<bool> _onWillPop() async {
      return true;
    }

    return Scaffold(
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
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(
                //left: 10.w, right: 10.w,
                bottom: 45.h,
                top: 20.h),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 250),
                      tween: Tween(
                        begin: 0.0,
                        end:  Provider.of<ControllerReg>(context, listen: true)
                            .position,
                      ),
                      builder:(context, val,_)=> LinearProgressIndicator(
                        // semanticsValue: '1.0',

                        minHeight: 9.h,
                        backgroundColor: bgrey,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(basicPink),
                        value: val as double
                      ),
                    ),
                  )),
            ),
          ),
          // Consumer(builder: (context, value, child) {
          //   return Provider.of<InfoProvider>(context, listen: false).index == 0
          //       ? Religion()
          //       : (Provider.of<InfoProvider>(context, listen: false).index == 1)
          //           ? Naming()
          //           : (Provider.of<InfoProvider>(context, listen: false)
          //                       .index ==
          //                   2)
          //               ? BirthDate()
          //               : Text("data");
        // })
           Expanded(
             // color: Colors.lightBlue,
             // width: MediaQuery.of(context).size.width*0.9,
               // height: MediaQuery.of(context).size.width*0.9,
               child: CustomRegisterView())
        ]),
      ),
    );
  }
}
