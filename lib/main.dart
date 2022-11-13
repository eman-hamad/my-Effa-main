import 'package:effah/constants.dart';
import 'package:effah/modules/app/app_repository.dart';
import 'package:effah/modules/app/app_storage.dart';
import 'package:effah/modules/app/effa_app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
   // systemNavigationBarColor: Colors.amber, // navigation bar color
    statusBarColor: basicPink, // status bar color
    statusBarIconBrightness: Brightness.light, // status bar icon color
   // systemNavigationBarIconBrightness: Brightness.dark, // color of navigation controls
  ));
  // await ScreenUtil.ensureScreenSize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(EffaApp(
    repository: AppRepository(
      KeyValueStorage(
        await SharedPreferences.getInstance(),
      ),
    ),
  ));
}
