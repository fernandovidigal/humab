import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class SmallPrimaryButton extends StatelessWidget {
  const SmallPrimaryButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.w,
      height: 32.h,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: kPrimaryColor,
          primary: Colors.white,
          //padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 14.sp),
        ),
        onPressed: press,
      ),
    );
  }
}
