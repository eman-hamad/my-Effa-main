import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../modules/basic_info_provider.dart';

class Religion extends StatelessWidget {
  @override
  bool press = false;

  late bool _loading;

  //late double _progressValue = progress;

  var items = [];

  List<myclass> religion = [
    myclass("مسلم"),
    myclass("مسيحي"),
  ];
  int tapIndex = 0;
  @override
  void initState() {
    // super.initState();
    _loading = false;
    // _progressValue = widget.progress;
    tapIndex = religion.length;
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            ' الديانة ؟',
            style: TextStyle(fontSize: 20.sp),
          ),
        )),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            alignment: Alignment.centerRight,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: llgrey, width: 1.w),
                borderRadius: BorderRadius.circular(15),
              ),
              color: white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                child: Consumer<InfoProvider>(builder: (_, a, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: religion.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            tapIndex = index;

                            press = true;

                            Provider.of<InfoProvider>(context, listen: false)
                                .rebuild();

                            _updateProgress(context);
                            postReligion(index + 1, context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 30.0.h, right: 10.w, left: 10.w),
                            child: Row(
                              children: [
                                // ListTile(
                                //   title: Text('${nationalites[index].word} '),
                                // ),
                                Icon(
                                  Icons.check,
                                  size: 30,
                                  color: tapIndex == index && press == true
                                      ? basicPink
                                      : transparnt,
                                ),
                                Spacer(),
                                Text(
                                  '${religion[index].word} ',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: tapIndex == index && press == true
                                          ? basicPink
                                          : black),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _updateProgress(BuildContext context) {
    Provider.of<InfoProvider>(context, listen: false).progressValue += 0.15;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _removeProgress(BuildContext context) {
    Provider.of<InfoProvider>(context, listen: false).progressValue -= 0.15;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void postReligion(int? religionId, BuildContext context) async {
    // final MyUser user =
    //     await UserManager().updateUser(id, religion_id: religionId);
    // if (user.religionId != 0) {
    //   //  Preferences.instance.setUser(user).then((value) {
    //   // Navigator.push(
    //   //     context,
    //   //     MaterialPageRoute(
    //   //         builder: (context) =>
    //   Navigator.push(context, PageRouteBuilder(pageBuilder:
    //       (BuildContext context, Animation<double> animation,
    //           Animation<double> secondaryAnimation) {
    //     return Options(
    //       gender: gender,
    //       id: id,
    //       progress: _progressValue,
    //     );
    //   }));
    // });
  }

  Widget item(i, religion) => Row(
        children: [
          // ListTile(
          //   title: Text('${religion[i].word} '),
          // ),
          Container(
              child: IconButton(
                  iconSize: 30,
                  hoverColor: basicPink,
                  onPressed: () {},
                  icon: (const Icon(Icons.check))))
        ],
      );
}

class myclass {
  String word;

  myclass(this.word);
}
