import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            backgroundColor: kPrimaryColor,
            primary: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14.h),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20.sp),
          ),
          onPressed: press,
        ),
      ),
    );
  }
}
