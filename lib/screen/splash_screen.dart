import 'package:flutter/material.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/widget/app_logo.dart';
import 'package:rejolute/widget/custom_scaffold.dart';
import 'package:rejolute/widget/loading_animation.dart';
// import 'package:workmanager/workmanager.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorResource.PRIMARY,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: ColorResource.BACKGROUND_WHITE,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              AppLogo(
                height: 300,
                width: 300,
              ),
              Spacer(),
              SizedBox(
                height: 50,
              ),
              LoadingAnimationIndicator(),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
