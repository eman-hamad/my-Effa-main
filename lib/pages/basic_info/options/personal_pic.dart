import 'dart:convert';
import 'dart:io';

import 'package:effah/constants.dart';
import 'package:effah/models/images_model.dart';
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
import '../birthdate_info.dart';

class PersonalPic extends StatefulWidget {
  PersonalPic({Key? key, required this.progress ,required this.id,
    required this.gender}) : super(key: key);
  late double progress;
  int? id;
  int gender;
  @override
  State<PersonalPic> createState() => _PersonalPicState();
}

class _PersonalPicState extends State<PersonalPic> {
  List<File> imageList=[];
  MyUser model = new MyUser();

   List<Images> images=[];
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    print("widget.id");
    print(widget.id);

      ///tafkeeeeeeeeeeeeer


  }

  // bool press = false;
  // late double _progressValue = widget.progress;
  // late File image = File('');
  // final picker = ImagePicker();

  // void _pickImageCamera() async {
  //   final pickedImage = await picker.getImage(source: ImageSource.gallery);
  //   final pickedImageFile = File(pickedImage!.path);
  //   setState(() {
  //     image = pickedImageFile;
  //     press = true;
  //   });

  //   //prefs.setString('stringValue', "the path to the new image");
  // }

  // late File image1 = File("");
  // // late File image1c = File("");
  // late XFile image2 = XFile("");
  // late File image3 = File("");
  // late File image= File("");
  //final picker = ImagePicker();
  // File _image = File("");

  // Future _pickImageCamera1() async {
  //   // try {
  //   //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   //   if (image == null) return;
  //   //   final imageTemp = File(image.path);
  //   //   setState(() => this.image = imageTemp);
  //   // } on PlatformException catch (e) {
  //   //   print('Failed to pick image: $e');
  //   // }

  //   try {
  //     final pickedImage =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);

  //     // if (pickedImage != null) return;
  //     final pickedImageFile = File(pickedImage!.path);

  //     setState(() {
  //       image1 = pickedImageFile;
  //       pressed1 = true;
  //       //press = true;

  //       // );
  //     });
  //   } on PlatformException catch (e) {
  //     // print("Failed to Pick Image :$e");
  //   }

  //   //prefs.setString('stringValue', "the path to the new image");
  // }

  // Future _pickImageCamera1c() async {
  //   try {
  //     final pickedImagec =
  //         await ImagePicker().pickImage(source: ImageSource.camera);
  //     // if (pickedImage != null) return;

  //     final pickedImageFilec = File(pickedImagec!.path);
  //     setState(() {
  //       this.image1 = pickedImageFilec;
  //       //press = true;
  //       pressed1 = true;
  //     });
  //   } on PlatformException catch (e) {
  //     // print("Failed to Pick Image :$e");
  //   }
  // }

  // //

  // final ImagePicker imagePicker = ImagePicker();
  // List<XFile>? imageFileList = [];

  // void selectImages() async {
  //   final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  //   if (selectedImages!.isNotEmpty) {
  //     imageFileList!.addAll(selectedImages);
  //   }
  //   // imageFileList!.insert(index, selectedImages);
  //   // print("Image List Length:" + imageFileList!.length.toString());
  //   pressed2 = true;
  //   setState(() {});
  // }

  // //  void selectImagesC() async {
  // //   final XFile? selectedImages= await imagePicker.pickImage(source:ImageSource.camera );
  // //   if (selectedImages!.isNotEmpty) {
  // //     imageFileList!.addAll(selectedImages);
  // //   }
  // //   print("Image List Length:" + imageFileList!.length.toString());
  // //   setState(() {});
  // // }

  // /////////////////////
  // // Future _pickImageCamera2() async {
  // //   try {
  // //     final pickedImage =
  // //         await ImagePicker().pickImage(source: ImageSource.gallery);

  // //     // if (pickedImage != null) return;
  // //     final pickedImageFile = File(pickedImage!.path);

  // //     setState(() {
  // //       image2 = pickedImageFile;

  // //       //press = true;
  // //       pressed2 = true;
  // //     });
  // //   } on PlatformException catch (e) {
  // //     // print("Failed to Pick Image :$e");
  // //   }
  // // }

  // Future _pickImageCamera2c() async {
  //   try {
  //     final pickedImagec =
  //         await ImagePicker().pickImage(source: ImageSource.camera);
  //     // if (pickedImage != null) return;

  //     final pickedImageFilec = XFile(pickedImagec!.path);
  //     setState(() {
  //       this.image2 = pickedImageFilec;
  //       imageFileList!.add(image2);
  //       //press = true;
  //       pressed2 = true;
  //     });
  //   } on PlatformException catch (e) {
  //     // print("Failed to Pick Image :$e");
  //   }
  // }
  // //
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
  Widget build(BuildContext context)  {
    // final model = Provider.of<AppStateProvider>(context, listen: false);
_onRefresh();
_ongetdata();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(children: [
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
          UploadPic(
            context: context,
            myFile: image1,
            press: pressed1,
            isFileChanged: (value) =>
                setState(() => image1 = value),
            isImg1: false,
            isImg2: false,
            isImg3: false,
            isImg4: false,
            isImg5: false,
            isImg6: false,
            isImg7: false,
            isProfile: true,
            images: images ,
            index: images.length>=1?0:-1,
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
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UploadPic(
                context: context,
                myFile: image2,
                isFileChanged: (value) =>
                    setState(() => image2 = value),
                press: pressed2,
                isImg1: false,
                isImg2: true,
                isImg3: false,
                isImg4: false,
                isImg5: false,
                isImg6: false,
                isImg7: false,
                images: images ,
                index: images.length>=2?1:-1,
                isProfile: false,
              ),
              SizedBox(
                width: 7.w,
              ),
              UploadPic(
                context: context,
                myFile: image3,
                isFileChanged: (value) =>
                    setState(() => image3 = value),
                press: pressed3,
                isImg1: false,
                isImg2: false,
                isImg3: true,
                isImg4: false,
                isImg5: false,
                isImg6: false,
                isImg7: false,
                images: images ,
                index: images.length>=3?2:-1,
                isProfile: false,
              ),
              SizedBox(
                width: 7.w,
              ),
              UploadPic(
                context: context,
                myFile: image4,
                press: pressed4,
                isFileChanged: (value) =>
                    setState(() => image4 = value),
                isImg1: false,
                isImg2: false,
                isImg3: false,
                isImg4: true,
                isImg5: false,
                isImg6: false,
                isImg7: false,
                images: images ,
                index: images.length>=4?3:-1,
                isProfile: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UploadPic(
                context: context,
                myFile: image5,
                press: pressed5,
                isFileChanged: (value) =>
                    setState(() => image5 = value),
                isImg1: false,
                isImg2: false,
                isImg3: false,
                isImg4: false,
                isImg5: true,
                isImg6: false,
                isImg7: false,
                images: images ,
                index: images.length>=5?4:-1,
                isProfile: false,
              ),
              SizedBox(
                width: 7.w,
              ),
              UploadPic(
                context: context,
                myFile: image6,
                press: pressed6,
                isFileChanged: (value) =>
                    setState(() => image6 = value),
                isImg1: false,
                isImg2: false,
                isImg3: false,
                isImg4: false,
                isImg5: false,
                isImg6: true,
                isImg7: false,
                images: images ,
                index: images.length>=6?5:-1,
                isProfile: false,
              ),
              SizedBox(
                width: 7.w,
              ),
              UploadPic(
                context: context,
                myFile: image7,
                press: pressed7,
                isFileChanged: (value) =>
                    setState(() => image7 = value),
                isImg1: false,
                isImg2: false,
                isImg3: false,
                isImg4: false,
                isImg5: false,
                isImg6: false,
                images: images ,
                index: images.length>=7?6:-1,
                isImg7: true,
                isProfile: false,
              ),
            ],
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

                    if ((UploadPic.isUploadedImg2 == true &&
                            UploadPic.isUploadedImg3 == true) ||
                        (UploadPic.isUploadedImg3 == true &&
                            UploadPic.isUploadedImg4 == true) ||
                        (UploadPic.isUploadedImg4 == true &&
                            UploadPic.isUploadedImg5 == true) ||
                        (UploadPic.isUploadedImg5 == true &&
                            UploadPic.isUploadedImg6 == true) ||
                        (UploadPic.isUploadedImg6 == true &&
                            UploadPic.isUploadedImg7 == true) ||
                        (UploadPic.isUploadedImg2 == true &&
                            UploadPic.isUploadedImg4 == true) ||
                        (UploadPic.isUploadedImg2 == true &&
                            UploadPic.isUploadedImg5 == true) ||
                        (UploadPic.isUploadedImg2 == true &&
                            UploadPic.isUploadedImg6 == true) ||
                        (UploadPic.isUploadedImg2 == true &&
                            UploadPic.isUploadedImg7 == true) ||
                        (UploadPic.isUploadedImg3 == true &&
                            UploadPic.isUploadedImg5 == true) ||
                        (UploadPic.isUploadedImg3 == true &&
                            UploadPic.isUploadedImg6 == true) ||
                        (UploadPic.isUploadedImg3 == true &&
                            UploadPic.isUploadedImg7 == true) ||
                        (UploadPic.isUploadedImg4 == true &&
                            UploadPic.isUploadedImg6 == true) ||
                        (UploadPic.isUploadedImg4 == true &&
                            UploadPic.isUploadedImg7 == true) ||
                        (UploadPic.isUploadedImg5 == true &&
                            UploadPic.isUploadedImg7 == true)) {
                     imageList.add(image1);
                     imageList.add(image2);
                     imageList.add(image3);
                     imageList.add(image4);
                     imageList.add(image5);
                     imageList.add(image6);
                     imageList.add(image7);
                     uploadimages(imageList, widget.id, context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: orginalRed,
                        content: Directionality(
                            textDirection: TextDirection.rtl,
                            child:
                                Text("تأكد من رفع صورتان شخصيتان علي الأقل")),
                      ));
                    }
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
  Future<void> _onRefresh() async {
    model = await Preferences.instance.getUserModel();
    //print("lllll${model.frName}");
    setState(() {
      model;
    });
  }
  void uploadimages(List<File> files, int? id, BuildContext context) async {
    final MyUser user =
    await UserManager().uploadImages(files, id);
    if (user.id != 0) {
      Navigator.pop(context);
    }
  }

  Future<void> _ongetdata() async {
    images=await UserManager().getImages(widget.id!);

setState(() {
  images;
});

  }
}

