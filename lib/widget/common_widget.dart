import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/image_resource.dart';
import 'package:rejolute/widget/custom_app_bar.dart';
import 'package:rejolute/widget/custom_text.dart';

Widget buildAppBar() {
  return CustomAppBar(
    appBarBackgroundColor: ColorResource.PRIMARY,
    centerWidget: Image.asset(
      ImageResource.APP_LOGO,
      height: 30,
    ),
  );
}

Widget showDateTimePicker(
    {@required BuildContext? context,
    @required DateTime? mainTime,
    bool isOnlyDate = false}) {
  DateTime? tempstartDateTime;
  return Container(
    color: Color.fromARGB(255, 255, 255, 255),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomAppBar(
          isInnerPage: true,
          appBarBackgroundColor: Colors.transparent,
          appBarName: '',
          trailingWidget: CustomText(
            "Save",
            fontSize: 14,
            color: ColorResource.BRIGHT_BLUE_007AFF,
          ),
          onTrailingWidgetActionPressed: () {
            if (tempstartDateTime != null) {
              mainTime = tempstartDateTime;
            }
            Navigator.pop(context!, mainTime);
          },
          onBackButtonPressed: () {
            Navigator.pop(context!);
          },
        ),
        Container(
          height: 250,
          child: (!isOnlyDate)
              ? CupertinoDatePicker(
                  initialDateTime: mainTime != null ? mainTime : DateTime.now(),
                  onDateTimeChanged: (val) {
                    tempstartDateTime = val;
                  })
              : CupertinoDatePicker(
                  initialDateTime: mainTime != null ? mainTime : DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (val) {
                    tempstartDateTime = val;
                  }),
        ),
      ],
    ),
  );
}
