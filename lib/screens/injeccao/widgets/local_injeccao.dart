import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class LocalInjeccao extends StatelessWidget {
  const LocalInjeccao({
    Key? key,
    this.large = false,
    this.selected = false,
    this.press,
  }) : super(key: key);

  final bool large;
  final bool selected;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: large ? 35.w : 26.w,
        height: large ? 100.h : 50.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: selected
              ? kPrimaryColor.withOpacity(0.4)
              : kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: selected ? kPrimaryColor : kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
      ),
    );
  }
}
