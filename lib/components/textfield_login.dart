import 'package:effah/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldLogin extends StatelessWidget {
  // final TextEditingController? phoneController;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? txt;
  // GlobalKey<FormState> form = GlobalKey<FormState>();
  const TextFieldLogin(
      {Key? key,
      // this.phoneController,
      this.controller,
      this.validator,
      this.txt})
      : super(key: key);

  // String? get _errorText {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            // scrollPadding: EdgeInsets.only(
            //   bottom: MediaQuery.of(context).viewInsets.bottom
            // ),
            // controller: phoneController,
            enabled: false,
            decoration: InputDecoration(
              border: InputBorder.none,

              hintText: txt,
              hintStyle:const TextStyle(color: black),
              filled: false,
              // labelText: 'code',
            ),
          ),
          flex: 1,
        ),
        const SizedBox(height: 25, child: VerticalDivider(color: Colors.black)),
        Expanded(
          child: TextFormField(
                    scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +160.h
            ),
            controller: controller,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            // validator:  (text) {
            //       if (!(text!.length > 5) && text.isNotEmpty) {
            //         return "Enter valid name of more then 5 characters!";
            //       }
            //       return null;
            //     },
            keyboardType: TextInputType.number,
            // maxLength: 10,
            validator: validator,
            cursorColor: basicPink,
            decoration: const InputDecoration(
              border: InputBorder.none,
              // errorText: _errorText,

              filled: false,
              // labelText: 'mobile',
              hintText: "1234567890",
              // prefixIcon: Icon(Icons.mobile_screen_share),
            ),
            // onSaved: (String? value) {},
          ),
          flex: 5,
        ),
      ],
    );
  }
}