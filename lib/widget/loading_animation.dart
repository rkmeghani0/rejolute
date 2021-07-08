import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingAnimationIndicator extends StatelessWidget {
  final double? width;
  final double? height;

  const LoadingAnimationIndicator({
    this.width = 120,
    this.height = 120,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CupertinoActivityIndicator(
      radius: 20,
    ));
  }
}
