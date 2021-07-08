import 'package:flutter/material.dart';
import 'package:rejolute/util/color_resource.dart';

class CustomScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final bool? isBottomReSize;
  final bool? fullScreen;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Drawer? endDrawer;
  final Key? key;
  final bool? isPrimary;
  final bool? isExtendBody;

  CustomScaffold(
      {this.appBar,
      this.body,
      this.backgroundColor = ColorResource.PRIMARY,
      this.isBottomReSize = false,
      this.fullScreen = false,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.bottomNavigationBar,
      this.endDrawer,
      this.key,
      this.isPrimary = false,
      this.isExtendBody = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: isBottomReSize!,
      backgroundColor: backgroundColor!,
      primary: isPrimary!,
      appBar: appBar,
      body: _buildBody(context),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      endDrawer: endDrawer,
      extendBody: isExtendBody!,
      //extendBodyBehindAppBar: true
    );
  }

  Widget _buildBody(BuildContext context) {
    if (fullScreen!)
      return _buildLoader(context);
    else
      return SafeArea(
          child: Container(
              color: ColorResource.BACKGROUND_WHITE,
              child: _buildLoader(context)));
  }

  Widget _buildLoader(BuildContext context) {
    return Container(
      color: ColorResource.BACKGROUND_WHITE,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: body,
      ),
    );
  }
}
