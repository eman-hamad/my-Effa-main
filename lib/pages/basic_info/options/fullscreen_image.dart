import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../../constants.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({Key? key, required this.images}) : super(key: key);
  List<String> images;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  final _totalDots = 4;

  double _currentPosition = 0.0;

  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1.0;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Swiper(
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int i) => Image.asset(
            widget.images[i],
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          loop: false,
          // onTap: (v) {
          //    _updatePosition(v.toDouble());
          //   print(v);
          // },

          onIndexChanged: (value) => _updatePosition(value.toDouble()),

          itemCount: widget.images.length,
        ),
        Positioned(
          left: 10.w,
          top: 50.h,
          // alignment: Alignment.topLeft,
          // heightFactor: 3,
          child: _buildRow([
            DotsIndicator(
              onTap: (v) => _updatePosition(v),
              dotsCount: _totalDots,
              position: _currentPosition,
              axis: Axis.horizontal,
              reversed: true,
              decorator: DotsDecorator(
                size: const Size.square(11.0),
                activeColor: red,
                color: white,
                activeSize: Size(25.0.w, 11.0.h),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ]),
        ),
        Positioned(
          bottom: 20.h,
          right: 0,
          left: 0,
          // alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 50.0.w,
              height: 50.0.h,
              child: Icon(Icons.close),
              decoration: new BoxDecoration(
                color: white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
