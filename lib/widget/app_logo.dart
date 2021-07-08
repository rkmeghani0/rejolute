import 'package:flutter/material.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/image_resource.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;

  AppLogo({this.height = 50, this.width = 100});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: ColorResource.BACKGROUND_WHITE,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            ImageResource.APP_LOGO,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
