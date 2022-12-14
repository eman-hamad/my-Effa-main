import 'package:effah/constants.dart';
import 'package:effah/managers/nationality_manager.dart';
import 'package:effah/models/controller_reg.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../managers/user_manager.dart';
import '../../models/nationality_model.dart';
import '../../models/user_model.dart';
import '../../modules/basic_info_provider.dart';

class NationalityInfo extends StatefulWidget {
  NationalityInfo({Key? key, this.id, this.gender}) : super(key: key);
  final int? id;
  int? gender;

  @override
  State<NationalityInfo> createState() => _NationalityInfoState();
}

class _NationalityInfoState extends State<NationalityInfo> {
//   @override
  bool press = false;

  late bool _loading;

  TextEditingController editingController = TextEditingController();

  int tapIndex = 0;

  Future<List<Nationality>>? myNationalityList;

  @override
  Widget build(BuildContext context) {
    myNationalityList = NationalityManager().getNationality();

    return Column(children: [
      Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Text(
          ' الجنسية ؟',
          style: TextStyle(fontSize: 20.sp),
        ),
      )),
      Padding(
        padding:
            EdgeInsets.only(right: 30.w, left: 30.w, bottom: 8.h, top: 8.h),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            onTap: () {
              if (editingController.selection ==
                  TextSelection.fromPosition(TextPosition(
                      offset: editingController.text.length - 1))) {
                // setState(() {
                editingController.selection = TextSelection.fromPosition(
                    TextPosition(offset: editingController.text.length));
                Provider.of<InfoProvider>(context, listen: false).rebuild();
                // });
              }
            },
            cursorColor: basicPink,
            onChanged: (value) {
              // setState(() {});
              Provider.of<InfoProvider>(context, listen: false).rebuild();
            },

            controller: editingController,
            // cursorColor: basicPink,
            decoration: const InputDecoration(
              hintText: " بحث ... ",

              //[focusedBorder], displayed when [TextField, InputDecorator.isFocused] is true
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: grey),
              ),
              focusColor: basicPink,
              fillColor: basicPink,

              prefixIcon: Icon(
                Icons.search,
                color: basicPink,
              ),
              // border: OutlineInputBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(25.0)))
            ),
          ),
        ),
      ),
      Expanded(
        // flex: 5,
        child: Container(
          alignment: Alignment.centerRight,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: white, width: 0.3.w),
              borderRadius: BorderRadius.circular(15),
            ),
            color: white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              child: Consumer<InfoProvider>(builder: (_, a, child) {
                return FutureBuilder<List<Nationality>>(
                    future: myNationalityList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if (editingController.text.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    final ref = Provider.of<ControllerReg>(
                                        context,
                                        listen: false);
                                    tapIndex = index;
                                    press = true;
                                    Provider.of<InfoProvider>(context, listen: false).rebuild();
                                    _updateProgress(context);
                                    ref.onTap(0.85 );
                                    ControllerReg.nationaityID=snapshot.data![index].id;
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 30.0.h,
                                        right: 10.w,
                                        left: 10.w),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: 30,
                                          color: tapIndex == index &&
                                                  press == true
                                              ? basicPink
                                              : transparnt,
                                        ),
                                        const Spacer(),
                                        Text(
                                          snapshot.data![index]
                                              .name!, // '${nationalites[index].word} ',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: tapIndex == index &&
                                                      press == true
                                                  ? basicPink
                                                  : black),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (snapshot.data![index].name!
                                      .contains(editingController.text) ||
                                  snapshot.data![index].name!
                                      .contains(editingController.text)) {
                                return InkWell(
                                  onTap: () {
                                    tapIndex = index;
                                    final ref = Provider.of<ControllerReg>(context, listen: false);
                                    press = true;
                                    Provider.of<InfoProvider>(context, listen: false).rebuild();
                                    editingController.clear();
                                    _updateProgress(context);
                                      ref.onTap(0.85  );
                                       ControllerReg.nationaityID=snapshot.data![index].id;
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 30.0.h,
                                        right: 10.w,
                                        left: 10.w),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: 30,
                                          color: tapIndex == index &&
                                                  press == true
                                              ? basicPink
                                              : transparnt,
                                        ),
                                        const Spacer(),
                                        Text(
                                          snapshot.data![index].name!,
                                          // '${nationalites[index].word} ',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: tapIndex == index &&
                                                      press == true
                                                  ? basicPink
                                                  : black),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    });
              }),
            ),
          ),
        ),
      ),
    ]);
  }



  void _updateProgress(BuildContext context) {
    //Provider.of<InfoProvider>(context, listen: false).updateProgress(_progressValue);
    Provider.of<InfoProvider>(context, listen: false).progressValue += 0.15;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _removeProgress(BuildContext context) {
    // Provider.of<InfoProvider>(context, listen: false).removeProgress(_progressValue);
    Provider.of<InfoProvider>(context, listen: false).progressValue -= 0.15;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }
}

