import 'dart:async';

import 'package:effah/models/user_model.dart';
import 'package:effah/modules/app/app_entity.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:effah/pages/auth/login_page.dart';
import 'package:effah/pages/auth/pin_page.dart';
import 'package:effah/pages/complate_info.dart';
import 'package:effah/pages/home_page.dart/home_page.dart';
import 'package:effah/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../preferences/preferences.dart';
import 'basic_info/options/options.dart';

class SpalshScreen extends StatefulWidget {
  final dynamic currentPage;

  const SpalshScreen({Key? key, this.currentPage}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  MyUser? model;
  var _duration = Duration(milliseconds:2000);
  @override
  void initState() {
    super.initState();
    _onRefresh();
   Timer(_duration,transition);
  }
  Future<void> _onRefresh() async {
    model = await Preferences.instance.getUserModel();
    setState(() {
      model;
    });
    // if (model != null) {
    //   if (model!.isLogin == 0) {
    //     print(model);
    //     Future.delayed(const Duration(seconds: 14), () {
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => widget.currentPage()),);
    //     });
    //   } else {
    //     Future.delayed(const Duration(seconds: 14), () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => Options(
    //                 gender: model!.gender!,
    //                 id: model!.id,
    //                 progress: 0,
    //               )));
    //     });
    //   }
    // }

  }

  // void transition() async{
  //   var navPage;
  //
  //   Consumer<AppStateProvider>(builder: (context, model, child){
  //     // ignore: prefer_typing_uninitialized_variables
  //     switch (model.state) {
  //       case AppState.authenticated:
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => HomePage()),
  //               (Route<dynamic> route) => false,
  //         );
  //         navPage = HomePage();
  //         break;
  //       case AppState.unauthenticated:
  //         print(navPage);
  //         navPage = LoginPage();
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => LoginPage()),
  //               (Route<dynamic> route) => false,
  //         );
  //         break;
  //       case AppState.notCompleted:
  //         navPage = ComplateInfo();
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => ComplateInfo()),
  //               (Route<dynamic> route) => false,
  //         );
  //         break;
  //       case AppState.notVerified:
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => PinPage()),
  //               (Route<dynamic> route) => false,
  //         );
  //         navPage = PinPage();
  //         break;
  //       default:
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => AppLoading()),
  //               (Route<dynamic> route) => false,
  //         );
  //         navPage = AppLoading();
  //     }
  //     return navPage;
  //   }
  //   );
  //
  //
  // }
  void transition() async{

    var navPage;
    navPage = await Provider.of<AppStateProvider>(context, listen: false);

    switch (navPage.state) {
      case AppState.authenticated:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
        );
        break;
      case AppState.unauthenticated:
        Navigator.push(context,
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                return LoginPage();
              },
              transitionDuration: Duration.zero,
            ));
        break;
      // case AppState.notCompleted:
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => ComplateInfo()),
      //         (Route<dynamic> route) => false,
      //   );
      //   break;
      case AppState.notVerified:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PinPage()),
              (Route<dynamic> route) => false,
        );

        break;
      default:
        Navigator.pushAndRemoveUntil(
          context,

          MaterialPageRoute(builder: (context) => AppLoading()),
              (Route<dynamic> route) => false,
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/image/background.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/image/icon.png",width: 181,),
            SizedBox(height: 100,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
