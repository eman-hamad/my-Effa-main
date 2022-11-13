import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class CodeInput extends StatelessWidget {
  final FocusNode? focusNode0;
  // final FocusNode? focusNode1;
  // final FocusNode? focusNode2;
  TextEditingController controller = TextEditingController();
  CodeInput({Key? key, this.focusNode0, required this.controller
      // this.focusNode1,
      // this.focusNode2,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      child: TextField(
        cursorColor: basicPink,
        controller: controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        // validator:  (text) {
        //       if (!(text!.length > 5) && text.isNotEmpty) {
        //         return "Enter valid name of more then 5 characters!";
        //       }
        //       return null;
        //     },
        keyboardType: TextInputType.number,
        //scrollPadding: EdgeInsets.only(top:10.h),
        focusNode: focusNode0,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (str) {
          if (str.length == 1) {
            // FocusScope.of(context).requestFocus(focusNode2);
            FocusScope.of(context).nextFocus();
          } else if (str.length == 0) {
            // FocusScope.of(context).requestFocus(focusNode0);
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          // hintText: "*",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: bblack, width: 2.3),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          counterText: "",
          focusColor: basicPink,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: basicPink, width: 3.0),
          ),
        ),
      ),
    );
  }
}
