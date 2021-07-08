import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/font.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool? obscureText;
  final TextEditingController? controller;
  final Function? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final Color? primaryColor;
  final Color? textColor;
  final Color? errorColor;
  final Font? inputTextFont;
  final double? inputTextSize;
  final bool? isReadOnly;
  final bool? ignorePadding;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? hintText;
  final Font? hintTextFont;
  final Color? hintTextColor;
  final double? hintTextSize;
  final String? errorText;
  final String? labelText;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? borderUnderlineColor;
  final Color? focusColor;
  final Function? onSuffixIconPressed;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final ValueChanged<String>? onValueChanged;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? lstTextInputFormatter;
  final Iterable<String>? autofillHint;

  const TextFormFieldWidget({
    @required this.hintText,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.obscureText = false,
    this.controller,
    this.functionValidate,
    this.parametersValidate,
    this.actionKeyboard = TextInputAction.next,
    this.onSubmitField,
    this.onFieldTap,
    this.prefixIcon,
    this.suffixIcon,
    this.primaryColor = ColorResource.PRIMARY,
    this.textColor = ColorResource.BLACK,
    this.errorColor = ColorResource.RED_FF6C5F,
    this.inputTextFont = Font.SfUiMedium,
    this.inputTextSize = 12,
    this.ignorePadding = false,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.hintTextFont = Font.SfUiMedium,
    this.hintTextColor,
    this.hintTextSize,
    this.errorText,
    this.labelText,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.focusColor,
    this.borderUnderlineColor,
    this.onSuffixIconPressed,
    this.suffixIconColor,
    this.suffixIconSize,
    this.onValueChanged,
    this.isReadOnly = false,
    this.textAlign = TextAlign.start,
    this.lstTextInputFormatter,
    this.autofillHint,
  });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 12;
  // bool hasfocus;
  @override
  void initState() {
    super.initState();
    // if (widget.focusNode != null) {
    //   widget.focusNode.addListener(_onFocusChange());
    // }
  }

  // _onFocusChange() {
  //   if (widget.focusNode != null) {
  //     print("Focus Node Focus State");
  //     print("Focus: " + widget.focusNode.hasFocus.toString());
  //     // setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: widget.primaryColor,
      ),
      child: TextFormField(
        cursorColor: widget.primaryColor,
        obscureText: widget.obscureText!,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        textInputAction: widget.actionKeyboard,
        focusNode: widget.focusNode,
        style: TextStyle(
          color: widget.textColor,
          // color: (widget.focusColor != null)
          //     ? (widget.focusNode != null)
          //         ? (widget.focusNode.hasFocus)
          //             ? widget.focusColor
          //             : widget.textColor
          //         : widget.textColor
          //     : widget.textColor,
          fontFamily: widget.inputTextFont!.value,
          fontSize: widget.inputTextSize,
          fontWeight: FontWeight.w200,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        initialValue: widget.defaultText,
        autofillHints: widget.autofillHint,
        readOnly: widget.isReadOnly!,
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        textAlign: widget.textAlign!,
        decoration: InputDecoration(
          isCollapsed: widget.ignorePadding!,
          counterText: widget.maxLength != null ? "" : null,
          contentPadding: widget.ignorePadding!
              ? EdgeInsets.only(
                  bottom: 2,
                  top: 15,
                )
              : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: widget.hintTextFont!.value,
            color: widget.hintTextColor,
            fontSize: widget.hintTextSize,
          ),
          // errorText: widget.errorText,
          // errorStyle: TextStyle(
          //   color: ColorResource.RED_FF6C5F,
          //   fontFamily: Font.SfUiMedium.value,
          // ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              fontFamily: widget.hintTextFont!.value,
              color: widget.hintTextColor,
              fontSize: widget.hintTextSize),
          enabledBorder: widget.enabledBorderColor != null
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.enabledBorderColor!,
                    width: 0.5,
                  ),
                )
              : InputBorder.none,
          focusedBorder: widget.focusedBorderColor != null
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor!,
                    width: 0.5,
                  ),
                )
              : InputBorder.none,
          border: widget.borderUnderlineColor != null
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderUnderlineColor!,
                    width: 0.5,
                  ),
                )
              : InputBorder.none,
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  icon: Icon(
                    widget.suffixIcon,
                    size: widget.suffixIconSize,
                    color: widget.suffixIconColor,
                  ),
                  onPressed: onTextFieldSuffixIconPressed,
                )
              : null,
        ),

        controller: widget.controller,
        inputFormatters: widget.lstTextInputFormatter,
        // validator: (value) {
        //   if (widget.functionValidate != null) {
        //     String resultValidate =
        //         widget.functionValidate(value, widget.parametersValidate);
        //     if (resultValidate != null) {
        //       return resultValidate;
        //     }
        //   }
        //   return null;
        // },
        onFieldSubmitted: (value) {
          if (widget.onSubmitField != null) widget.onSubmitField!(value);
        },
        onChanged: widget.onValueChanged,
        onTap: () {
          if (widget.onFieldTap != null) widget.onFieldTap!();
        },
      ),
    );
  }

  onTextFieldSuffixIconPressed() {
    // Unfocus all focus nodes
    // textFieldFocusNode.unfocus();

    // Disable text field's focus node request
    // textFieldFocusNode.canRequestFocus = false;

    widget.onSuffixIconPressed!();

    //Enable the text field's focus node request after some delay
    // Future.delayed(Duration(milliseconds: 100), () {
    //   textFieldFocusNode.canRequestFocus = true;
    // });
  }
}

String? commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
  currentFocus!.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
