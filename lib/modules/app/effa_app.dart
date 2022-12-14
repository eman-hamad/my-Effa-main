import 'package:effah/constants.dart';
import 'package:effah/models/controller_reg.dart';
import 'package:effah/models/posts/api_posts.dart';
import 'package:effah/models/user_model2.dart';
import 'package:effah/modules/app/app_entity.dart';
import 'package:effah/modules/app/app_repository.dart';
import 'package:effah/pages/complate_info.dart';
import 'package:effah/pages/home_page.dart/home_page.dart';
import 'package:effah/pages/loading.dart';
import 'package:effah/pages/auth/login_page.dart';
import 'package:effah/pages/auth/pin_page.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:effah/pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../basic_info_provider.dart';

class EffaApp extends StatefulWidget {
  final AppRepository repository;

  const EffaApp({required this.repository});

  @override
  State<EffaApp> createState() => _EffaAppState();
}

class _EffaAppState extends State<EffaApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: InfoProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ControllerReg(),),
        ChangeNotifierProvider(create: (context) => Posts(),),
        ChangeNotifierProvider(create: (context) => USERDATA(),),
        ChangeNotifierProvider(
          create: (_) => AppStateProvider(repository: widget.repository),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        // minTextAdapt: true,
        //splitScreenMode: true,
        builder: ((context, child) => Directionality(
          textDirection: TextDirection.rtl,
            // MaterialApp(
            //   title: 'Flutter RTL',
            //   color: Colors.grey,
            //   builder: (BuildContext context, Widget child) {
            //     return new Directionality(
            //       textDirection: TextDirection.rtl,
            //       child: new Builder(
            //         builder: (BuildContext context) {
            //           return new MediaQuery(
            //             data: MediaQuery.of(context).copyWith(
            //               textScaleFactor: 1.0,
            //             ),
            //             child: child,
            //           );
            //         },
            //       ),
            //     );
            //   },
            //       .
          child: MaterialApp(
              theme: ThemeData(
                  primaryColor: white,
                  primarySwatch: MaterialColor(
                    Colors.black.value,
                    const <int, Color>{
                      50: Colors.black,
                      100: Colors.black,
                      200: Colors.black,
                      300: Colors.black,
                      400: Colors.black,
                      500: Colors.black,
                      600: Colors.black,
                      700: Colors.black,
                      800: Colors.black,
                      900: Colors.black,
                    },
                  ),

                  //  appBarTheme: SystemUiOverlayStyle.light.copyWith(           statusBarColor: Theme.of(context).primaryColor,         ),
                  appBarTheme: AppBarTheme(
                       systemOverlayStyle: SystemUiOverlayStyle.dark,
                  ),
                  fontFamily: 'JFFlat',
                  scrollbarTheme: ScrollbarThemeData().copyWith(
                    thumbColor: MaterialStateProperty.all(transparnt),
                  )),
              debugShowCheckedModeBanner: false,


              // routes: {
              //   "/login": (_) => LoginPage(),
              //   "/Home": (_) => HomeMain(),
              //   "/pinPage": (_) => PinPage(),
              //   "/complet": (_) => CompleteInfo()

              //   // put our new route here ...
              //   // '/': (context) => currentPage,
              // },
              home: SpalshScreen()),
        )),
      )
    );
  }
}