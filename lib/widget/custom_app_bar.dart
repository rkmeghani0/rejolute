import 'package:flutter/material.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/font.dart';
import 'package:rejolute/widget/custom_text.dart';

class CustomAppBar extends StatefulWidget {
  final bool isInnerPage;
  final Function? onTrailingWidgetActionPressed;
  final Color appBarBackgroundColor;
  final Function? onBackButtonPressed;
  final String? appBarName;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  final Widget? centerWidget;
  final Color leadingColor;

  CustomAppBar({
    this.isInnerPage = false,
    this.onTrailingWidgetActionPressed,
    this.onBackButtonPressed,
    this.appBarBackgroundColor = ColorResource.BACKGROUND_WHITE,
    this.appBarName,
    this.trailingWidget,
    this.leadingWidget,
    this.leadingColor = ColorResource.PRIMARY,
    this.centerWidget,
  });
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: widget.appBarBackgroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        margin: const EdgeInsets.only(top: 0.0),
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
              left: 0,
              child: buildLeadingIcon(),
            ),
            Positioned(
                left: 0,
                right: 0,
                //flex: 1,
                child: (widget.centerWidget != null)
                    ? widget.centerWidget!
                    : (widget.appBarName != null)
                        ? buildCenterIcon()
                        : Container()),
            Positioned(
                right: 0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    constraints: BoxConstraints(minWidth: 50),
                    padding: EdgeInsets.only(right: 8),
                    child: buildTrailingWidget(),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildLeadingIcon() {
    if (widget.isInnerPage) {
      if (widget.leadingWidget == null) {
        return Align(
          alignment: Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(minWidth: 50),
            margin: EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 16,
              color: widget.leadingColor,
              onPressed: () {
                if (widget.onBackButtonPressed != null) {
                  widget.onBackButtonPressed!();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      } else {
        return Align(
            alignment: Alignment.topLeft,
            child: Container(
                constraints: BoxConstraints(minWidth: 50),
                margin: EdgeInsets.only(left: 8),
                child: widget.leadingWidget));
      }
    } else {
      return Container(
        constraints: BoxConstraints(minWidth: 50),
        margin: EdgeInsets.only(left: 8),
      );
    }
  }

  Widget buildCenterIcon() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: CustomText(
          widget.appBarName!,
          font: Font.SfUiBold,
          color: ColorResource.BACKGROUND_WHITE,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildTrailingWidget() {
    if (widget.trailingWidget != null &&
        widget.onTrailingWidgetActionPressed != null)
      return InkWell(
        onTap: () {
          if (widget.onTrailingWidgetActionPressed != null) {
            widget.onTrailingWidgetActionPressed!();
          }
        },
        child: Align(
            alignment: Alignment.centerRight, child: widget.trailingWidget),
      );
    else
      return Container();
  }
}
