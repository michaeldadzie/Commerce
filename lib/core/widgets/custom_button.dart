import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/screen_sizes.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color bordersideColor;
  final Color backgroundColor;
  final Color textColor;
  final Function onPress;
  const CustomButton({
    @required this.title,
    @required this.bordersideColor,
    @required this.backgroundColor,
    @required this.textColor,
    @required this.onPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(
        MyScreenSizes.screenWidth,
        MyScreenSizes.screenHeight,
      ),
      allowFontScaling: true,
    );
    return Container(
      width: MediaQuery.of(context).size.width - 40.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.only(
            left: 30.h,
            right: 30.h,
            top: 20.h,
            bottom: 20.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: backgroundColor,
          side: BorderSide(
            width: 2.h,
            color: bordersideColor,
          ),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
