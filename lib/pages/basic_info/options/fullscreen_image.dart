import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:effah/api_constants.dart';
import 'package:effah/models/images_model.dart';
import 'package:effah/models/user_model2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:image_network/image_network.dart';

import '../../../constants.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({Key? key, required this.images}) : super(key: key);
  List<ImagesUser> images;

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
          itemBuilder: (BuildContext context, int i) =>
              CachedNetworkImage(
                imageUrl: ApiConstants.imagebaseUrl + widget.images[i].image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        ),
                  ),
                ),
                placeholder: (context, url) =>Center(child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
          //     ImageNetwork(
          //   image: ApiConstants.imagebaseUrl + widget.images[i].image,
          //   fitAndroidIos: BoxFit.cover,
          //   height: double.infinity,
          //   width: double.infinity,
          //   curve: Curves.easeIn,
          //   onPointer: true,
          //   onLoading: const CircularProgressIndicator(
          //     color: Colors.indigoAccent,
          //   ),
          //   onError: const Icon(
          //     Icons.error,
          //     color: Colors.red,
          //   ),
          // ),
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
