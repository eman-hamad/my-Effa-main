import 'dart:convert';
import 'dart:io';

import 'package:effah/components/reusable_widgets/pick_image_register.dart';
import 'package:effah/constants.dart';
import 'package:effah/models/images_model.dart';
import 'package:effah/models/posts/api_posts.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:effah/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../components/reusable_widgets/upload_pic.dart';
import '../../../components/reusable_widgets/wait_bottomsheet.dart';
import '../../../managers/user_manager.dart';
import '../../../models/user_model.dart';
import '../../../modules/basic_info_provider.dart';

class PersonalPic extends StatefulWidget {
  PersonalPic({Key? key, required this.id, required this.gender})
      : super(key: key);

  int? id;
  int gender;

  @override
  State<PersonalPic> createState() => _PersonalPicState();
}

class _PersonalPicState extends State<PersonalPic> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  List<File> imageList = [];
  MyUser model = new MyUser();

  List<Images> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.id");
    print(widget.id);

    ///tafkeeeeeeeeeeeeer
  }

  File image1 = File("");
  File image2 = File("");
  File image3 = File("");

  bool pressed1 = false;
  bool pressed2 = false;
  bool pressed3 = false;

  File image4 = File("");
  File image5 = File("");
  File image6 = File("");
  File image7 = File("");

  bool pressed4 = false;
  bool pressed5 = false;
  bool pressed6 = false;
  bool pressed7 = false;

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<AppStateProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
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
                'الصور الشخصية',
                // textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 25.h,
          ),
          UploadPicRigister(
            isProfile: true,
            myFile: image1,
            press: pressed1,
          ),
          SizedBox(
            height: 35.h,
          ),
          Directionality(
              textDirection: TextDirection.rtl,
              child: Row(children: [
                SvgPicture.asset("assets/icon/pic.svg"),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'المزيد من الصور الشخصية',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ])),
          imageFileList!.isNotEmpty
              ? SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.445,
                    child: imageFileList!.isNotEmpty
                        ? Wrap(
                            children: List.generate(
                            imageFileList!.length + 1,
                            (index) {
                              return index == 0
                                      ? InkWell(
                                          onTap: () async {
                                            // if (imageFileList!.length >= 8) {
                                            // } else {
                                             imageFileList!.clear();
                                               selectImages();

                                            //}
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.02,
                                                  vertical: 10),
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3 -
                                                  0.12 -
                                                  30.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.grey[300],
                                              ),
                                              child: const Icon(Icons.add,
                                                  size: 40)),
                                        )
                                      : Stack(children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.02,
                                                  vertical: 10),
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3 -
                                                  0.12 -
                                                  30.w,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                    File(imageFileList![index - 1]
                                                        .path),
                                                    fit: BoxFit.fill,
                                                  ))),
                                          IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                print(index-1);
                                                imageFileList!.removeAt(index - 1);

                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        ]);
                            },
                          ))
                        : const SizedBox(),
                  ),
              )
              : Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () async {
                        // if (imageFileList!.length >= 8) {
                        // } else {
                        imageFileList!.clear();
                          selectImages();

                       // }
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        child: const Icon(Icons.add,size: 40)
                      ),
                    ),
                ],
              ),
          SizedBox(
            height: 30.h,
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text('تأكيد',
                        style: TextStyle(
                          color: white,
                          fontSize: 16.sp,
                        )),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: basicPink,
                    // primary: Colors.teal,
                    // onSurface: Colors.yellow,
                    // side: BorderSide(color: Colors.teal, width: 2),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    print(UploadPic.isUploadedImg1);
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
                      // barrierColor: liGrey.withOpacity(0.8),
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
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
                    child: SvgPicture.asset(
                        // AssetImage(
                        "assets/icon/9.svg"),
                  ),
                  //   size: 50,
                  //   color: white,
                  // ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          )
        ]),
      ),
    );
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      // imageFileList!.addAll(selectedImages);

      for (int i = 0; i < 8 ; i++) {
        setState(() {
          imageFileList!.add(selectedImages[i]);
        });
      }
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  Future<void> _onRefresh() async {
    model = await Preferences.instance.getUserModel();
    //print("lllll${model.frName}");
    setState(() {
      model;
    });
  }

  void uploadimages(List<File> files, int? id, BuildContext context) async {
    final MyUser user = await UserManager().uploadImages(files, id);
    if (user.id != 0) {
      Navigator.pop(context);
    }
  }

  Future<void> _ongetdata() async {
    images = await UserManager().getImages(widget.id!);

    setState(() {
      images;
    });
  }
}
