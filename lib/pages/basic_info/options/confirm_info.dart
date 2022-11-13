// ignore_for_file: use_function_type_syntax_for_parameters

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:effah/constants.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../api_constants.dart';
import '../../../components/reusable_widgets/upload_id.dart';
import '../../../components/reusable_widgets/wait_bottomsheet.dart';
import '../../../managers/user_manager.dart';
import '../../../models/user_model.dart';
import '../../../models/user_upload_images_model.dart';
import '../../../modules/basic_info_provider.dart';
import '../../../preferences/preferences.dart';
import '../birthdate_info.dart';

class ConfirmInfo extends StatefulWidget {
  ConfirmInfo({Key? key,
    required this.progress,
    required this.id,
    required this.gender})
      : super(key: key);
  late double progress;
  int? id;
  int gender;

  @override
  State<ConfirmInfo> createState() => _ConfirmInfoState();
}

class _ConfirmInfoState extends State<ConfirmInfo> {
  late double _progressValue = widget.progress;
  File image1 = File("");
  File image2 = File("");
  File image3 = File("");

  bool pressed1 = false;
  bool pressed2 = false;
  bool pressed3 = false;

  MyUser model = new MyUser();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    _onRefresh();
    // final model = Provider.of<AppStateProvider>(context, listen: false);
    // TextEditingController firstName = TextEditingController();
    // TextEditingController secondName = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: transparnt,
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SizedBox(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
            SizedBox(
            height: 65.h,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(children: [
              SvgPicture.asset("assets/icon/nextto.svg"),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'تأكيد بياناتي',
                // textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 40.h,
          ),
          Directionality(
              textDirection: TextDirection.rtl,
              child: Row(children: [
                SvgPicture.asset("assets/icon/pic.svg"),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'صور الهوية الشخصية ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ])),
          SizedBox(
            height: 15.h,
          ),
          Row(children: [
            Expanded(
                child: UploadID(
                    context: context,
                    myFile: image1,
                    press: pressed1,
                    isImg1: true,
                    isImg2: false,
                    isImg3: false,
                    txt: 'الصورة الخلفية',
                    isFileChanged: (value) =>
                        setState(() => image1 = value),

                          myWidget: Padding(
                            padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                            child: model.identity_back != null &&image1.uri
                                .toString()
                                .isEmpty?
                            CachedNetworkImage(
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 96.0,
                                  height: 96.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    //border: Border.all(color: Appc.colorPrimary,width: 1),

                                  ),
                                  child: CircleAvatar(
                                    radius: 96.0,
                                    backgroundImage: imageProvider,
                                  ),
                                );
                              },
                              imageUrl: ApiConstants.imagebaseUrl+model.identity_back!,
                              width: 96.0,
                              height: 96.0,
                              placeholder: (context, url) {
                                return SvgPicture.asset("assets/icon/img.svg");
                              },
                              errorWidget: (context, url, error) {
                                return SvgPicture.asset("assets/icon/img.svg");
                              },
                            ) :
                            image1.uri
                                .toString()
                                .isNotEmpty ? Image.file(
                              image1,


                              fit: BoxFit.cover,
                            ) :SvgPicture.asset("assets/icon/img.svg"),
                          ),
                        )),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: UploadID(
                      context: context,
                      myFile: image2,
                      press: pressed2,
                      isFileChanged: (value) =>
                          setState(() => image2 = value),
                      isImg1: false,
                      isImg2: true,
                      isImg3: false,
                      txt: 'الصورة الأمامية',
                      myWidget: Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                        child: model.identity_face != null&&image2.uri
                            .toString()
                            .isEmpty  ?
                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: 96.0,
                              height: 96.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //border: Border.all(color: Appc.colorPrimary,width: 1),

                              ),
                              child: CircleAvatar(
                                radius: 96.0,
                                backgroundImage: imageProvider,
                              ),
                            );
                          },
                          imageUrl: ApiConstants.imagebaseUrl+model.identity_face!,
                          width: 96.0,
                          height: 96.0,
                          placeholder: (context, url) {
                            return SvgPicture.asset("assets/icon/img.svg");
                          },
                          errorWidget: (context, url, error) {
                            return SvgPicture.asset("assets/icon/img.svg");
                          },
                        ) : image2.uri
                            .toString()
                            .isNotEmpty ? Image.file(
                          image2,


                          fit: BoxFit.cover,
                        ) : SvgPicture.asset("assets/icon/img.svg"),
                      ),
                    )),
                ]),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.w, left: 10.w),
                    child: Divider(
                      thickness: 1.w,
                      color: black,
                    ),
                  ),
                ),
                Text(
                  "او",
                  style: TextStyle(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 30.w),
                    child: Divider(
                      thickness: 1.w,
                      color: black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child: Row(children: [
                  SvgPicture.asset("assets/icon/pic.svg"),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'صور جواز السفر',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ])),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
                child: UploadID(
                  context: context,
                  myFile: image3,
                  press: pressed3,
                  isImg1: false,
                  isImg2: false,
                  isImg3: true,
                  isFileChanged: (value) =>
                      setState(() => image3 = value),
                  txt: 'صورة جواز السفر',
                  myWidget: Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                    child: model.passport_image != null &&image3.uri
                        .toString()
                        .isEmpty?
                    CachedNetworkImage(
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 96.0,
                          height: 96.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //border: Border.all(color: Appc.colorPrimary,width: 1),

                          ),
                          child: CircleAvatar(
                            radius: 96.0,
                            backgroundImage: imageProvider,
                          ),
                        );
                      },
                      imageUrl:ApiConstants.imagebaseUrl+ model.passport_image!,
                      width: 96.0,
                      height: 96.0,
                      placeholder: (context, url) {
                        return SvgPicture.asset("assets/icon/img.svg");
                      },
                      errorWidget: (context, url, error) {
                        return SvgPicture.asset("assets/icon/img.svg");
                      },
                    ) :
                    image3.uri
                        .toString()
                        .isNotEmpty ? Image.file(
                      image3,


                      fit: BoxFit.cover,
                    ) :
                    SvgPicture.asset("assets/icon/img.svg"),
                  ),
                )),
            Row(children: [
              Expanded(
                child: TextButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text('تأكيد',
                        style: TextStyle(
                            color: white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: basicPink,
                    // primary: Colors.teal,
                    // onSurface: Colors.yellow,
                    // side: BorderSide(color: Colors.teal, width: 2),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    // setState(() {
                    //     print(image3);
                    // print(pressed3);
                    // });
                    print(UploadID.isUploadedImg1);

                    if ((UploadID.isUploadedImg1 == false ||
                        UploadID.isUploadedImg2 == false) &&
                        UploadID.isUploadedImg3 == false) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        backgroundColor: orginalRed,
                        content: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                                "تأكد من رفع الصورة الأمامية والخلفية أو صورة الجواز")),
                      ));
                    } else {
                      UserImages user = UserImages();
                      print("dddd${image1.uri.toString()}");
                      user.image1 = image1;
                      user.image2 = image2;
                      user.image3 = image3;
                      uploadimages(user, widget.id, context);
                    }
                    _updateProgress(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             BirthDateInfo(progress: _progressValue)));
                  },
                ),
              ),
              SizedBox(
                width: 15.h,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      //   barrierColor: liGrey.withOpacity(0.8),
                      backgroundColor: transparnt,
                      builder: (context) {
                        return WaitBottomSheet();
                      });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: ggrey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.h, horizontal: 12.w),
                    child: SvgPicture.asset(
                      // AssetImage(
                        "assets/icon/9.svg"),
                  ),
                  //   size: 50,
                  //   color: white,
                  // ),
                ),
              ),
            ]),
            SizedBox(
              height: 20.h,
            )
          ]),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    model = await Preferences.instance.getUserModel();
    //print("lllll${model.frName}");
    setState(() {
      model;
    });
  }
}

void uploadimages(UserImages userImages, int? id, BuildContext context) async {
  final MyUser user =
  await UserManager().confirmInfo(userImages, id);
  if (user.id != 0) {
    Navigator.pop(context);
  }
}

void _updateProgress(BuildContext context) {
  //_progressValue += 0.1;
  Provider.of<InfoProvider>(context, listen: false).rebuild();
}
