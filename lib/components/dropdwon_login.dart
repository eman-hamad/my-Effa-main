import 'package:effah/constants.dart';
import 'package:effah/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdwonLogin extends StatelessWidget {
  // final CountryModel? dropdownValue;
  final TextEditingController? phoneController;
  final Function onChanged;
  final String? errorText;
  final String? txt;
  // final List<CountryModel>? dropdownItems;
  Widget? icon;
  DropdwonLogin(
      {Key? key,
      // this.dropdownValue,
      required this.onChanged,
      this.errorText,
      this.phoneController,
      this.txt,
      this.icon
      // this.dropdownItems
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: InputDecorator(
          decoration: InputDecoration(),
          child: Row(
            children: [
              Container(
                child: icon,
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                //  flex: 3,
              child: Text('$txt' ,
              style: TextStyle(
                color: black,
                fontSize: 14.sp
              ),
              
               ),
                // child: InputDecorator(
                  
                // //  enabled: false,
                //   decoration: InputDecoration(hintText: txt),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
