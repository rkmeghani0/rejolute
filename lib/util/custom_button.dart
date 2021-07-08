import 'package:flutter/material.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/font.dart';
import 'package:rejolute/widget/custom_text.dart';

class CustomButton extends StatefulWidget {
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? color;
  final Function? onPressed;

  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;

  final double? shadowBlurRadius;
  final Color? shadowColor;
  final Offset? shadowOffset;

  final double? verticalPadding;
  final double? horizontalPadding;
  final double? verticalMargin;
  final double? horizontalMargin;

  final String? buttonText;
  final Font? buttonTextFont;
  final double? buttonTextSize;
  final Color? buttonTextColor;

  final String? leadingImage;
  final double? leadingImageHeight;
  final double? leadingImageWidth;
  final double? leadingImagePadding;

  final String? trailingImage;
  final double? trailingImageHeight;
  final double? trailingImageWidth;
  final double? trailingImagePadding;

  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final double? leadingIconSize;

  CustomButton(
    this.buttonText, {
    this.buttonHeight,
    this.buttonWidth = double.infinity,
    this.borderWidth,
    this.borderColor,
    this.shadowBlurRadius,
    this.shadowColor,
    this.shadowOffset,
    this.buttonTextColor,
    this.leadingImage,
    this.leadingIcon,
    this.leadingIconColor = ColorResource.PRIMARY,
    this.leadingIconSize = 14,
    this.onPressed,
    this.trailingImage,
    this.color,
    this.buttonTextFont = Font.SfUiMedium,
    this.borderRadius = 0,
    this.verticalPadding = 5,
    this.horizontalPadding = 5,
    this.buttonTextSize = 14,
    this.leadingImageHeight = 24,
    this.leadingImageWidth = 24,
    this.trailingImageHeight = 24,
    this.trailingImageWidth = 24,
    this.verticalMargin = 0,
    this.horizontalMargin = 0,
    this.leadingImagePadding = 8,
    this.trailingImagePadding = 8,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius!),
      ),
      margin: EdgeInsets.symmetric(
        vertical: widget.verticalMargin!,
        horizontal: widget.horizontalMargin!,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.onPressed!();
          },
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          child: Container(
            width: widget.buttonWidth,
            height: widget.buttonHeight,
            padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding!,
              horizontal: widget.horizontalPadding!,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              color: widget.color,
              boxShadow: <BoxShadow>[
                if (widget.shadowColor != null)
                  BoxShadow(
                    blurRadius: widget.shadowBlurRadius!,
                    color: widget.shadowColor!,
                    offset: widget.shadowOffset!,
                  )
              ],
              border: widget.borderColor != null
                  ? Border.all(
                      width: widget.borderWidth!,
                      color: widget.borderColor!,
                    )
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.leadingImage != null)
                  Container(
                    padding: EdgeInsets.only(
                        right: widget.leadingImagePadding!, left: 24),
                    child: Image.asset(
                      widget.leadingImage!,
                      width: widget.leadingImageWidth,
                      height: widget.leadingImageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (widget.leadingIcon != null)
                  Container(
                    padding: EdgeInsets.only(
                      right: widget.leadingImagePadding!,
                    ),
                    child: Icon(
                      widget.leadingIcon,
                      size: widget.leadingIconSize,
                      color: widget.leadingIconColor,
                    ),
                  ),
                Flexible(
                  child: CustomText(
                    widget.buttonText!,
                    font: widget.buttonTextFont!,
                    fontSize: widget.buttonTextSize!,
                    color: widget.buttonTextColor!,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (widget.trailingImage != null)
                  Column(
                    children: [
                      SizedBox(width: 5),
                      Container(
                        padding: EdgeInsets.only(
                            left: widget.trailingImagePadding!, right: 24),
                        child: Image.asset(
                          widget.trailingImage!,
                          width: widget.trailingImageWidth,
                          height: widget.trailingImageHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

ButtonTheme raisedButton(
    {VoidCallback? onClick,
    String? text,
    Color? textColor,
    Color? color,
    Color? splashColor,
    double? borderRadius,
    double? minWidth,
    double? height,
    Color? borderSideColor,
    TextStyle? style,
    Widget? leadingIcon,
    Widget? trailingIcon}) {
  return ButtonTheme(
    minWidth: minWidth!,
    height: height!,
    child: RaisedButton(
        splashColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25),
            side: BorderSide(color: borderSideColor!)),
        textColor: Colors.white,
        color: ColorResource.PRIMARY,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // This is must when you are using Row widget inside Raised Button
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLeadingIcon(leadingIcon!),
            Text(
              text ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
            ),
            _buildtrailingIcon(trailingIcon!),
          ],
        ),
        onPressed: () {
          return onClick!();
        }),
  );
}

Widget _buildLeadingIcon(Widget leadingIcon) {
  if (leadingIcon != null) {
    return Row(
      children: <Widget>[leadingIcon, SizedBox(width: 10)],
    );
  }
  return Container();
}

Widget _buildtrailingIcon(Widget trailingIcon) {
  if (trailingIcon != null) {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        trailingIcon,
      ],
    );
  }
  return Container();
}
