import 'package:flutter/material.dart';
import 'package:humab/helpers/screen_helper.dart';

class ActionButton extends StatelessWidget {
  final int currentPage;
  final int pagesCount;
  final GestureTapCallback? press;

  const ActionButton({Key? key, this.currentPage = 0, this.pagesCount = 0, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        primary: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        currentPage != (pagesCount - 1) ? "Seguinte" : "Finalizar",
        style: TextStyle(fontSize: 18.sp),
      ),
      onPressed: press,
    );
  }
}
