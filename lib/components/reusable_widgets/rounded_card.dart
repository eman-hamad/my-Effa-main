import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard(
      {Key? key,
      required this.width,
      required this.height,
      required this.mywidget})
      : super(key: key);
  final double width, height;
  final Widget mywidget;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: 13.h, bottom: 13.h, right: 15.w, left: 15.w),
        child: SizedBox(width: width, height: height, child: mywidget),
      ),
    );
  }
}
