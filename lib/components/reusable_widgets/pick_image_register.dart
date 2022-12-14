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


class UploadPicRigister extends StatefulWidget {
 UploadPicRigister({Key? key,required this.myFile,
   required this.press,required this.isProfile,}) : super(key: key);

 File myFile;
 bool press;
 bool isProfile;
  @override
  State<UploadPicRigister> createState() => _UploadPicState();
}

class _UploadPicState extends State<UploadPicRigister> {
  Future UploadImage(File file) async{
    print("objecfffffffffffffffffffffffffffft");
    if (file != null) {
      print("objecfffffffffffffffffffffffffffft");
      bool auth = Provider.of<Posts>(context, listen: false).isImageUploaded;
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext ctx){
            return Center(child: CircularProgressIndicator(),);
          }
      );
      print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
      // setState(() {
      //   loader =true;
      // });
      try {
        auth = await Provider.of<Posts>(context, listen: false)
            .updateImg(
            file,
            context
        );
      } on HttpExeption catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$e"),
              duration: const Duration(seconds: 2),
            )
        );
        // Navigator.of(context).pop();
        // setState(() {
        //   loader = false;
        // });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$e"),
              duration: const Duration(seconds: 2),
            )
        );
        // setState(() {
        //   loader = false;
        // });
      } finally {
        print("objecffffffffffffffffffffffffbbbbbbbbbbbbbbbbbbbbbbbbbbbbfffft");
      }
      // setState(() {
      //   _fileImage = File(pickedFile.path);
      //   loader = false;
      // });
    } else {}
  }
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
                                    await UploadImage(pickedImageFilec);
                                    setState(() {
                                      widget.myFile = pickedImageFilec;
                                      widget.press = true;
                                      Navigator.pop(context);
                                      Navigator.pop(context);
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
          child:
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
            imageUrl: "ApiConstants.imagebaseUrl +widget.images.elementAt(widget.index).image!",
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
          child:
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
              imageUrl:"",
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
