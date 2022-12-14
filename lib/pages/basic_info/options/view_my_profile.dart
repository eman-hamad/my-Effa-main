import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:effah/api_constants.dart';
import 'package:effah/constants.dart';
import 'package:effah/models/user_model2.dart';
import 'package:effah/pages/basic_info/options/fullscreen_image.dart';
// import 'package:carousel1/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';

class ViewMyProfile extends StatefulWidget {
  const ViewMyProfile({Key? key}) : super(key: key);

  @override
  State<ViewMyProfile> createState() => _ViewMyProfileState();
}

List chips1 = [
  "الطول 172 سم",
  "الوزن 70 كجم",
  "ابيض",
  "اجيد السباحة",
];

List chips2 = [
  "مسلم",
  "أحيانا يفوتني الصلاه",
  "لا ادخن",
  // "لا اصلي في المسجد",
  "عزباء",
  // "ملتزم",
  // "اصوم رمضان فقط"
];
List chips3 = [
  "مدرس",
  "مؤهل جامعي",
  "جامعة القاهرة",
];
List chips4 = [
  "الوالد موجود",
  "الوالده موجوده",
];

class _ViewMyProfileState extends State<ViewMyProfile> {
  bool loader = false;
  Future<void> getMemberData() async {
    setState(() {
      loader = true;
    });
    try {
      await Provider.of<USERDATA>(context, listen: false).fetchMembers1();
      setState(() {
        loader = false;
      });
    } catch (e) {
      setState(() {
        loader = false;
      });
      throw (e);
    }
  }
  @override
  void initState() {
    getMemberData();
    // TODO: implement initState
    super.initState();
  }
 int? _totalDots;
  double _currentPosition = 0.0;

  double _validPosition(double position) {
    if (position >= _totalDots!) return 0;
    if (position < 0) return _totalDots! - 1.0;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  final CarouselController _controller = CarouselController();

  List _isHovering = [false, false, false, false, false, false, false];
  //List _isSelected = [true, false, false, false, false, false, false];
  bool _isSelected = true;
  int _current = 0;

  // final List<String> images = [
  //   "assets/image/personal_pic.png",
  //   "assets/image/personal_pic.png",
  //   "assets/image/personal_pic.png",
  //   "assets/image/personal_pic.png",
  // ];
  List<bool> EditingText = [false, false, false, false];

  bool _isEditingText = false;

  String myText =
      "حالتها الأجتماعيه (عازباء) أن تكوت يخشي الله قبل الناس متفاهمه ذي طاقة إيجابية ومجتهده وصبوره";
  String txtPartener =
      " الاعتماد علي النفس و الأجتهاد في العمل أحب المرح والضحك والوضوح في الامور بشكل عام ";



  List<Widget> generateImageTiles(screenSize, List<ImagesUser> images) {
    return images
        .map(
          (element) =>
           ClipRRect(
              // clipBehavior: Clip.none,
              borderRadius: BorderRadius.circular(18.0),
              child:
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FullScreenImage(images: images)));
                },
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.imagebaseUrl+element.image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,

                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(child: SizedBox(
                    height: 30,
                    width: 30,
                      child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            )
        )
        .toList();
  }

  @override
  void dispose() {
    // _editing1Controller.dispose();
    // controller[0].dispose();
    //  controller[1].dispose();
    //   controller[2].dispose();
    //    controller[3].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<USERDATA>(context, listen: false);

    var screenSize = MediaQuery.of(context).size;

    return loader? Scaffold(body: Center(child: CircularProgressIndicator(),),):Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bGround,
      appBar: AppBar(
        elevation: 7,
        //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.orange),
        shadowColor: lliGrey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: white,
        title: Center(
          child: Text(
            "مشاهدة حسابي",
            style: TextStyle(
                color: black,
                //fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset("assets/icon/arrow_back.svg"),
            //   // AssetImage("./././assets/icon/arrow_back.png"),
            //   color: black,
            // ),
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
        leading: Container(),
      ),
      body: FutureBuilder(
        future: Provider.of<USERDATA>(context, listen: false)
            .fetchMembers1(),
        builder: (context,AsyncSnapshot snp){
          _totalDots = ref.user!.images!.length;
          return
          SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.only(right: 10.w, left: 10.w, top: 9.h, bottom: 30.h),
              child: Column(children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: white,
                    child: Column(children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: CarouselSlider(
                              items: generateImageTiles(screenSize,ref.user!.images!),
                              options: CarouselOptions(
                                  padEnds: false,
                                  aspectRatio: 1,
                                  viewportFraction: 1,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                  scrollDirection: Axis.vertical,
                                  onPageChanged: (index, reason) {
                                    _updatePosition(index.toDouble());
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                              carouselController: _controller,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Positioned(
                              bottom: 18.h,
                              right: 30.w,
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Spacer(),
                                    Row(children: [
                                      // SizedBox(
                                      //   width: 5.w,
                                      // ),
                                      Text(
                                        ref.user!.user!.fullName,
                                        style: TextStyle(
                                          // letterSpacing: 8,
                                          //decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.sp,
                                          // fontSize: screenSize.width / 25,
                                          color: white,
                                        ),
                                      ),
                                      Text(
                                        ",",
                                        style: TextStyle(
                                          // letterSpacing: 8,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.sp,
                                          // decoration: TextDecoration.none,
                                          // fontFamily: 'Electrolize',
                                          // fontSize: screenSize.width / 25,
                                          color: white,
                                        ),
                                      ),
                                      Text(
                                        "${ref.user!.user!.age}",
                                        style: TextStyle(
                                          // letterSpacing: 8,
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.bold,
                                          // fontSize: screenSize.width / 25,
                                          color: white,
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(children: [
                                      SvgPicture.asset("assets/icon/stat.svg"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'أعزب',
                                        style: TextStyle(
                                            fontSize: 14.sp, color: white),
                                      ),

                                      SizedBox(
                                        width: 12.w,
                                      ),

                                      SvgPicture.asset("assets/icon/al.svg"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'مصري',
                                        style: TextStyle(
                                            fontSize: 14.sp, color: white),
                                      ),

                                      SizedBox(
                                        width: 12.w,
                                      ),

                                      SvgPicture.asset("assets/icon/ba.svg"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'مدرس',
                                        style: TextStyle(
                                            fontSize: 14.sp, color: white),
                                      ),


                                    ]),
                                  ]),
                            ),
                          ),
                          Positioned(
                            left: 10.w,
                            top: 10.h,
                            // alignment: Alignment.topLeft,
                            // heightFactor: 3,
                            child: _buildRow([
                              DotsIndicator(
                                onTap: _updatePosition,
                                dotsCount: _totalDots!,
                                position: _currentPosition,
                                axis: Axis.horizontal,
                                reversed: true,
                                decorator: DotsDecorator(
                                  size: const Size.square(11.0),
                                  activeColor: red,
                                  color: white,
                                  activeSize: Size(25.0.w, 11.0.h),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          child: Row(children: [
                            SvgPicture.asset("assets/icon/stu.svg"),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'مؤهل جامعي',
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            SizedBox(
                              width: 20.h,
                            ),
                            const SizedBox(
                                height: 25, child: VerticalDivider(color: grey)),
                            SvgPicture.asset("assets/icon/loc.svg"),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'مصر',
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            Text(
                              '/',
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            Text(
                              'القاهرة',
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            Text(
                              '/',
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            Text(
                              'المعادي',
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                          ]),
                        ),
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0.h),
                  child: Container(
                      width: double.infinity,
                      child: Card(
                        // margin: EdgeInsets.only(
                        //   // top: 20.0,
                        //   //bottom: 20.0,
                        // ),
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: white,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 15.0.w,
                                left: 15.0.w,
                                top: 25.h,
                                bottom: 33.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icon/2.svg"),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Text(
                                        'البيانات الشخصية & الجسدية',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),

                                  Wrap(
                                    spacing: 5.0,
                                    //runSpacing: 6.0,
                                    children: List<Widget>.generate(chips1.length,
                                            (int index) {
                                          return _editTitleChip(
                                            //  controller1[index],
                                            chips1[index],

                                            // chips1[index],
                                            // _editingchip11Controller,
                                            // gg(index),
                                          );
                                        }),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 25.0.h, horizontal: 10.w),
                                    child: _separtor(),
                                  ),

                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icon/3.svg"),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Text(
                                        'الدين & الحالة الإجتماعية ',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Wrap(
                                    spacing: 5.0,
                                    // runSpacing: 3.0,
                                    children: List<Widget>.generate(chips2.length,
                                            (int index) {
                                          return _editTitleChip(
                                            //  controller2[index],
                                            chips2[index],

                                            // chips1[index],
                                            // _editingchip11Controller,
                                            // gg(index),
                                          );
                                        }),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 25.0.h, horizontal: 10.w),
                                    child: _separtor(),
                                  ),

                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icon/4.svg"),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Text(
                                        'التعليم & العمل',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Wrap(
                                    spacing: 5.0,
                                    // runSpacing: 4.0,
                                    children: List<Widget>.generate(chips3.length,
                                            (int index) {
                                          return _editTitleChip(
                                            // controller3[index],
                                            chips3[index],

                                            // chips1[index],
                                            // _editingchip11Controller,
                                            // gg(index),
                                          );
                                        }),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 25.0.h, horizontal: 10.w),
                                    child: _separtor(),
                                  ),

                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icon/5.svg"),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Text(
                                        'العائله',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Wrap(
                                    spacing: 5.0,
                                    // runSpacing: 6.0,
                                    children: List<Widget>.generate(chips4.length,
                                            (int index) {
                                          return _editTitleChip(
                                            // controller4[index],
                                            chips4[index],

                                            // chips1[index],
                                            // _editingchip11Controller,
                                            // gg(index),
                                          );
                                        }),
                                  ),

                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: 25.0.h, horizontal: 10.w),
                                  //   child: _separtor(),
                                  // ),

                                  // Row(
                                  //   children: [
                                  //     ImageIcon(
                                  //       AssetImage("assets/icon/interests.png"),
                                  //       size: 40,
                                  //       color: basicPink,
                                  //     ),
                                  //     Text(
                                  //       'اهتماماتي',
                                  //       style: TextStyle(
                                  //         fontSize: 16.sp,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  //                               Row( // REPLACE THIS WITH Wrap
                                  //   children: List.generate(
                                  //     chips1.length,
                                  //     (i) {
                                  //       return  _editTitleChip( _editing1Controller);
                                  //     },
                                  //   ),
                                  // ),

                                  // Wrap(
                                  //   spacing: 6.0,
                                  //   runSpacing: 6.0,
                                  //   children: List<Widget>.generate(chips5.length,
                                  //       (int index) {
                                  //     return _editTitleChip(
                                  //         controller5[index], chips5, index
                                  //         // chips1[index],
                                  //         // _editingchip11Controller,
                                  //         // gg(index),
                                  //         );
                                  //   }),
                                  // ),
                                  //  _editTitleChip(_editingchip1Controller),

                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 25.0.h, horizontal: 10.w),
                                      child: _separtor()),

                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icon/6.svg"),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Text(
                                        'وصف عنى',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 20.0.h,
                                      bottom: 20.0.h,
                                    ),
                                    child: _editTitleTextField("وصف عني", myText),
                                  ),

                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 25.0.h, horizontal: 10.w),
                                      child: _separtor()),

                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icon/6.svg"),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Text(
                                        'وصف عن شريكة حياتى',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 20.0.h,
                                    ),
                                    child: _editTitleTextField(
                                        "وصف عن شريك حياتي", txtPartener),
                                  ),
                                ]),
                          ),
                        ),
                      )),
                ),
              ]),
            ),
          );
        },
      )
    );
  }

  Widget _editTitleTextField(String txt, String txtValue) {
    return Container(
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: txt,
          labelStyle: TextStyle(
            color: basicPink,
            fontSize: 16.sp,
            //fontFamily: "verdana_regular",
            // fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
           
          ),
        ),
        child: Text(txtValue,
            style: TextStyle(
              color: black,
              fontSize: 14.0.sp,
            )),
      ),
    );
  }

  Widget _editTitleChip(
 
    String txt,
    
  ) {
    
    //   );
    return Chip(
      backgroundColor: white,
      side:
          BorderSide(color: lightPink, width: 1.7.w, style: BorderStyle.solid),
      label: Text(txt,
          style: TextStyle(
            color: black,
            fontSize: 14.0.sp,
          )),
     
    );
    //   ),
    // );
  }

  Widget _separtor() => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashWidth = 6.0;
          final dashHeight = 0.9;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: gseparate),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          );
        },
      );
}
