import 'package:effah/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldDetails extends StatelessWidget {
  // final TextEditingController? phoneController;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  // final String? txt;
  final String? hintTxt;
  // GlobalKey<FormState> form = GlobalKey<FormState>();
  const TextFieldDetails(
      {Key? key,
      // this.phoneController,
      this.controller,
      this.validator,
      // this.txt,
      this.hintTxt})
      : super(key: key);

  // String? get _errorText {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        cursorColor: basicPink,
        maxLines: 15,
        minLines: 7,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
          hintText: hintTxt,
          hintStyle: TextStyle(fontSize: 14.sp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: grey, width: 2.w),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: grey, width: 2.w),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
