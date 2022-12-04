import 'dart:async';

import 'package:effah/constants.dart';
import 'package:effah/pages/basic_info/options/bottom_tabs/filter/filter.dart';
import 'package:effah/pages/basic_info/options/bottom_tabs/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'bottom_tabs/home/home.dart';
import 'bottom_tabs/my_account/my_account.dart';
import '../../../components/no_notifications.dart';
import 'notifications.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key, required this.gender}) : super(key: key);
  int gender;
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int _selectedIndex = 0;
  // void _startTimer() {
  //   Timer(const Duration(seconds: 6), () {
  //     Navigator.pop(context);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => NoNotifications(progress: widget.progress,)));
  //   });
  // Timer(const Duration(seconds: 3), () {
  //   Navigator.pop(context);
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => MyProfile(
  //                 progress: widget.progress,
  //               )));

  // });
  //}
//   @override
//   void initState() {
//   super.initState();
//   _startTimer();
// }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      Home(gender: widget.gender),
      Filter(),
      MyAccount(),
      Settings()
    ];

    return Scaffold(
      backgroundColor: bGround,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: black,
        backgroundColor: white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: SvgPicture.asset(
              "assets/image/logo.svg",
              width: 66.w,
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(
            left: 8.w,
          ),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/icon/notif.svg",
              //   width: 140.w,
            ),
            // iconSize: 60.w,
            //color: Color.fromARGB(255, 180, 175, 175),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notifications()));
            },
          ),
        ),
      ),
      body:
          // SingleChildScrollView(
          //child:
          _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(color: lGrey, size: 40),
          showUnselectedLabels: true,
          unselectedLabelStyle:
              TextStyle(color: lGrey, fontWeight: FontWeight.bold),
          unselectedItemColor: lGrey,
          //mouseCursor: SystemMouseCursors.grab,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          selectedIconTheme: IconThemeData(color: basicPink, size: 40),
          selectedItemColor: basicPink,
          selectedLabelStyle: TextStyle(color: basicPink),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icon/tab4.svg", ),
              label: 'الرئيسية',
              activeIcon: SvgPicture.asset("assets/icon/tab4.svg", color: basicPink),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icon/tab3.svg" ,color: grey,),
              label: 'فلتر',
              activeIcon: SvgPicture.asset("assets/icon/tab3.svg", color: basicPink,),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icon/tab2.svg"),
              label: 'حسابي',
              activeIcon: SvgPicture.asset("assets/icon/tab2.svg" , color: basicPink,),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icon/tab1.svg"),
              label: 'الاعدادات',
              activeIcon: SvgPicture.asset("assets/icon/tab1.svg" , color: basicPink,),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    print(_selectedIndex);
    print(index);
    print("object");
    setState(() {
      _selectedIndex = index;
      // switch (_selectedIndex) {
      //   case 0:
      //     newColor0 = basicPink;
      //     break;

      //   case 1:
      //     newColor1 = basicPink;
      //     break;

      //   case 2:
      //     newColor2 = basicPink;
      //     break;

      //   case 3:
      //     newColor3 = basicPink;
      //     break;
      //   default:
      //     break;
      // }
      
    });
  }
}
