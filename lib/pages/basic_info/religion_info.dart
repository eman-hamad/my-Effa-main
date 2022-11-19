import 'package:effah/constants.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:effah/modules/basic_info_provider.dart';
import 'package:effah/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../managers/user_manager.dart';
import '../../models/user_model.dart';
import '../../modules/basic_info_provider.dart';
import '../../modules/basic_info_provider.dart';
import '../../modules/basic_info_provider.dart';
import 'options/options.dart';

class ReligionInfo extends StatelessWidget {
  ReligionInfo(
      {Key? key, required this.progress, this.id, required this.gender})
      : super(key: key);
  late double progress;
  int gender;
  bool press = false;
  final int? id;
  late bool _loading;

  late double _progressValue = progress;

  // TextEditingController editingController = TextEditingController();

  // final duplicateItems = List<String>.generate(10000, (i) => "Item $i");

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

  @override
  Widget build(BuildContext context) {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print(Provider.of<InfoProvider>(context, listen: false).progressValue);
    //  final model = Provider.of<AppStateProvider>(context, listen: false);
    // TextEditingController firstName = TextEditingController();
    // TextEditingController secondName = TextEditingController();
    print(Provider.of<InfoProvider>(context, listen: false).progressValue);
    Future<bool> _onWillPop() async {
      // return false; //<-- SEE HERE
      _removeProgress(context);

      return true;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0.0,
        //   backgroundColor: transparnt,
        // ),
        body: Column(children: [
          SizedBox(
            height: 65.h,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            // alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.w),
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
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, bottom: 45.h, top: 20.h),
            child: Consumer<InfoProvider>(builder: (context, g, _) {
              return Container(
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
              );
            }),
          ),
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
                              postReligion(index + 1,context);

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
                                        color:
                                            tapIndex == index && press == true
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
          ),
        ]),
      ),
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
    final MyUser user =
    await UserManager().updateUser(id, religion_id: religionId);
    if(user.religionId!=0){
      Preferences.instance.setUser(user).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Options(
                  gender: gender,
                  id: id,
                  progress: _progressValue,
                )));
      }
    );

    }
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
