import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/components/list_item_bg.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class DefinicoesItem extends StatelessWidget {
  const DefinicoesItem({
    Key? key,
    this.press,
    required this.title,
    this.optionValue,
  }) : super(key: key);

  final String title;
  final String? optionValue;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: ListItemBackground(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20.sp),
            ),
            Row(
              children: [
                Text(
                  optionValue ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: kGreyColor,
                  ),
                ),
                SizedBox(width: 22.w),
                SvgPicture.asset(
                  'assets/icons/right_arrow.svg',
                  height: 14.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
