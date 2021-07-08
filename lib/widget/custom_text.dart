import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rejolute/util/font.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? color;
  final double? lineHeight;
  final TextAlign? textAlign;
  final GestureTapCallback? onTap;
  final bool? isUnderLine;
  final bool? isSingleLine;
  final int? maxLines;
  final bool? allowCopy;
  final String? copyText;
  final FontWeight? fontWeight;
  final Font? font;

  CustomText(
    String text, {
    this.fontSize = 14,
    this.color = Colors.black,
    this.lineHeight = 1.21, // Line Height - 17
    this.textAlign = TextAlign.left,
    this.onTap,
    this.isUnderLine = false,
    this.isSingleLine = false,
    this.maxLines,
    this.allowCopy = false,
    this.copyText,
    this.fontWeight = FontWeight.normal,
    this.font = Font.SfUiMedium,
  }) : this.text = text;

  @override
  Widget build(BuildContext context) {
    Text textWidget = Text(
      this.text ?? "",
      textAlign: this.textAlign,
      overflow: isSingleLine! ? TextOverflow.ellipsis : null,
      softWrap: true,
      maxLines: maxLines,
      style: TextStyle(
          decoration:
              isUnderLine! ? TextDecoration.underline : TextDecoration.none,
          color: color,
          fontSize: fontSize,
          fontFamily: font!.value,
          height: lineHeight,
          fontWeight: fontWeight),
    );

    if (onTap != null || allowCopy!) {
      return GestureDetector(
        onTap: onTap,
        onLongPress: allowCopy!
            ? () {
                Clipboard.setData(new ClipboardData(text: this.copyText ?? ""));
              }
            : null,
        child: textWidget,
      );
    } else {
      return textWidget;
    }
  }
}
