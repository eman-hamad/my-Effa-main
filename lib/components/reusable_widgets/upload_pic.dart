import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:effah/models/posts/api_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../api_constants.dart';
import '../../constants.dart';
import '../../models/images_model.dart';

class UploadPic extends StatefulWidget {
  UploadPic(
      {Key? key,
      required this.myFile,
      required this.press,
      required this.isProfile,
      required this.isImg1,
      required this.isFileChanged,
      required this.isImg2,
      required this.isImg3,
      required this.isImg4,
      required this.isImg5,
      required this.isImg6,
      required this.isImg7,
      required this.index,
      required this.images,
      required this.context})
      : super(key: key);

  File myFile;
  bool press;
  ValueChanged<File> isFileChanged;
  bool isProfile;
  bool isImg1;
  bool isImg2;
  bool isImg3;
  bool isImg4;
  bool isImg5;
  bool isImg6;
  bool isImg7;
  int index = -1;
  List<Images> images;
  BuildContext context;

  static bool isUploadedImg1 = false;
  static bool isUploadedImg2 = false;
  static bool isUploadedImg3 = false;
  static bool isUploadedImg4 = false;
  static bool isUploadedImg5 = false;
  static bool isUploadedImg6 = false;
  static bool isUploadedImg7 = false;

  @override
  State<UploadPic> createState() => _UploadPicState();
}

class _UploadPicState extends State<UploadPic> {

  @override
  Widget build(BuildContext context) {
    // var pickedImage;
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 200.0.h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "اختر صورة",
                        style: TextStyle(
                          fontSize: 20.0.sp,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton.icon(
                                icon: const Icon(Icons.image),
                                onPressed: () async {
                                  try {
                                    final pickedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);

                                    final pickedImageFile =
                                        File(pickedImage!.path);

                                    setState(() {
                                      widget.myFile = pickedImageFile;

                                      widget.press = true;
                                      widget.isFileChanged(widget.myFile);

                                      if (widget.isImg1 == true) {
                                        UploadPic.isUploadedImg1 = true;
                                      }

                                      if (widget.isImg2 == true) {
                                        UploadPic.isUploadedImg2 = true;
                                      }

                                      if (widget.isImg3 == true) {
                                        UploadPic.isUploadedImg3 = true;
                                      }

                                      if (widget.isImg4 == true) {
                                        UploadPic.isUploadedImg4 = true;
                                      }

                                      if (widget.isImg5 == true) {
                                        UploadPic.isUploadedImg5 = true;
                                      }

                                      if (widget.isImg6 == true) {
                                        UploadPic.isUploadedImg6 = true;
                                      }

                                      if (widget.isImg7 == true) {
                                        UploadPic.isUploadedImg7 = true;
                                      }

                                      //       print("image1upload");
                                      print("sssss${widget.myFile}");
                                      // print("pressed1upload");
                                      // print(pressed1);
                                      Navigator.pop(context);
                                    });
                                  } on PlatformException catch (e) {
                                    // print("Failed to Pick Image :$e");
                                  }
                                },
                                label: const Text("الهاتف"),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.camera),
                                onPressed: () async {
                                  try {
                                    final pickedImagec = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);

                                    final pickedImageFilec =
                                        File(pickedImagec!.path);
                                    setState(() {
                                      // widget.press = false;
                                      widget.myFile = pickedImageFilec;

                                      widget.press = true;
                                      widget.isFileChanged(widget.myFile);

                                      if (widget.isImg1 == true) {
                                        UploadPic.isUploadedImg1 = true;
                                      }

                                      if (widget.isImg2 == true) {
                                        UploadPic.isUploadedImg2 = true;
                                      }

                                      if (widget.isImg3 == true) {
                                        UploadPic.isUploadedImg3 = true;
                                      }

                                      if (widget.isImg4 == true) {
                                        UploadPic.isUploadedImg4 = true;
                                      }

                                      if (widget.isImg5 == true) {
                                        UploadPic.isUploadedImg5 = true;
                                      }

                                      if (widget.isImg6 == true) {
                                        UploadPic.isUploadedImg6 = true;
                                      }
                                      if (widget.isImg7 == true) {
                                        UploadPic.isUploadedImg7 = true;
                                      }

                                      Navigator.pop(context);

                                      print("object");
                                      print(widget.press);
                                      print(widget.myFile);
                                    });
                                  } on PlatformException catch (e) {
                                    // print("Failed to Pick Image :$e");
                                  }
                                },
                                label: const Text("الكاميرا"),
                              ),
                            ]),
                      )
                    ],
                  ),
                );
              });
        },
        child: widget.isProfile == false ? upload() : uploadProfile());
  }

  Widget upload() => Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          width: 110.h,
          height: 110.h,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.images.isNotEmpty &&
                      widget.index > -1 &&
                      widget.myFile.path.toString().isEmpty
                  ? CachedNetworkImage(
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
                      imageUrl: ApiConstants.imagebaseUrl +
                          widget.images.elementAt(widget.index).image!,
                      width: 96.0,
                      height: 96.0,
                      placeholder: (context, url) {
                        return SvgPicture.asset("assets/icon/img.svg");
                      },
                      errorWidget: (context, url, error) {
                        return SvgPicture.asset("assets/icon/img.svg");
                      },
                    )
                  : widget.myFile.uri.toString().isNotEmpty
                      ? Image.file(
                          widget.myFile,
                          fit: BoxFit.cover,
                        )
                      : SvgPicture.asset(
                          "assets/image/addpic.svg",
                          // width: 60.w,
                          // height: 100.h,
                        )),
        ),
      );

  Widget uploadProfile() => Stack(children: [
        SizedBox(
          width: 160.w,
          height: 160.h,
          child: Container(

            decoration: BoxDecoration(
              border: Border.all(color: cgrey, width: 8.w),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: widget.images.isNotEmpty &&
                        widget.index > -1 &&
                        widget.myFile.path.toString().isEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
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
                          imageUrl: ApiConstants.imagebaseUrl +
                              widget.images.elementAt(widget.index).image!,
                          width: 96.0,
                          height: 96.0,
                          placeholder: (context, url) {
                            return SvgPicture.asset("assets/icon/img.svg");
                          },
                          errorWidget: (context, url, error) {
                            return SvgPicture.asset("assets/icon/img.svg");
                          },
                        ),
                    )
                    : (widget.myFile.path.isNotEmpty
                        ?
              ClipRRect(
                               borderRadius: BorderRadius.circular(100),
                               child: Image.file(
                                widget.myFile,
                                //  fit: BoxFit.fill,
                                fit: BoxFit.cover,
                                width: 150.h,
                                height: 150.h,
                            ),
                             )

                        : SvgPicture.asset(
                            "assets/image/addpic.svg",
                            //fit: BoxFit.cover,
                            fit: BoxFit.cover,
                            //  width: 160.h,
                            //   height: 160.w,
                          )),
              ),
            ),
          ),
        Positioned(
          left: 12.w,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: basicPink,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: ImageIcon(
                AssetImage("assets/icon/edit.png"),
                size: 45,
                color: white,
              ),
            ),
          ),
        )
      ]);
}
