import 'package:effah/components/dropdwon_login.dart';
import 'package:effah/components/textfield_login.dart';
import 'package:effah/constants.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:effah/pages/auth/pin_page.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../components/reusable_widgets/rounded_button.dart';
import '../../components/reusable_widgets/rounded_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _errorText;
  TextEditingController phoneController = TextEditingController();
  final _controller = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String countryName = "";
  String countryCode = "";
  CountryCode? myCode;
  bool is_pressed = true;
  final countryPicker = const FlCountryCodePicker(
    favorites: [
      'EG',
      'JO',
      'IQ',
      'LY',
      'QA',
      'SE',
      'SY',
      'TN',
      'PS',
      'KW',
      // 'DZ',
      // 'BH',

      'YE',
      'AE',
      'SA',
      'OM',
    ],
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // final model = Provider.of<AppStateProvider>(context, listen: false);
    //  FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        //WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 75.h,
                  // ),
                  Spacer(),
                  SvgPicture.asset(
                    "assets/image/logo.svg",
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  SizedBox(
                    height: 70.h,
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),

                  SvgPicture.asset(
                    "assets/image/line.svg",
                    // width:  MediaQuery.of(context).size.width/4,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: RoundedCard(
                        width: MediaQuery.of(context).size.width * .8,
                        height: MediaQuery.of(context).size.height / 7,
                        mywidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                final code = await countryPicker.showPicker(
                                    context: context);
                                setState(() {
                                  if (code != null) {
                                    myCode = code;
                                    countryName = code.name;
                                    countryCode = code.dialCode;
                                  }
                                });

                                if (code != null) print(code);
                                print("countryName");
                                print(countryCode);
                              },
                              child: DropdwonLogin(
                                icon: myCode != null
                                    ? myCode!.flagImage
                                    : countryPicker.countryCodes[63].flagImage,
                                txt: countryName == ""
                                    ? countryPicker.countryCodes[63].name
                                    //'اختيار الدولة'
                                    : countryName,

                                phoneController: phoneController,
                                onChanged: (newValue) {
                                  setState(() {});
                                },
                                // dropdownItems: _dropdownItems,
                                // dropdownItems: _dropdownItems,
                              ),
                            ),
                            Expanded(
                              child: TextFieldLogin(

                                txt: countryCode == ""
                                    ? countryPicker.countryCodes[63].dialCode
                                    : countryCode,
                                // form: form,
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return "أدخل رقم صحيح";
                                  }
                                  return null;
                                },

                                // phoneController: phoneController,
                                controller: _controller,
                              ),
                            )
                          ],
                        )),
                  ),

                  is_pressed
                      ? SizedBox(
                          //height: 44.h,
                          width: 148.w,
                          child: RoundedButton(
                            color: basicPink,
                            mywidget: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text('دخول',
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.normal)),
                            ),
                            raduis: 10,
                            myfun: () {
                              if (!form.currentState!.validate()) {
                                return;
                              }

                              //  else if (myCode == null) {
                              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //     backgroundColor: orginalRed,
                              //     content: Directionality(
                              //         textDirection: TextDirection.rtl,
                              //         child: Text("اختر الدولة للاستمرار")),
                              //   ));
                              //   return;
                              // }
                              setState(() {
                                is_pressed = false;
                              });
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return PinPage(
                                        name: countryName == ""
                                            ? countryPicker
                                                .countryCodes[63].name
                                            : countryName,
                                        code: countryCode == ""
                                            ? countryPicker
                                                .countryCodes[63].dialCode
                                            : countryCode,
                                        myPhone: _controller.text,
                                      );
                                    },
                                    transitionDuration: Duration.zero,
                                  ));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => PinPage(
                              //               name: countryName == ""
                              //             ? countryPicker.countryCodes[63].name :countryName,
                              //               code: countryCode == "" ?  countryPicker.countryCodes[63].dialCode : countryCode,
                              //               myPhone: _controller.text,
                              //             )));
                            },
                          ),
                        )
                      : CircularProgressIndicator(),

                  // Spacer(),
                  SizedBox(
                    height: 10.h,
                  ),

                  Container(
                    alignment: Alignment.center, // use aligment
                    child: SvgPicture.asset(
                      'assets/image/wedding.svg',
                      width: 321.06.w,
                      // width: double.infinity,
                      //height: 173.13.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
