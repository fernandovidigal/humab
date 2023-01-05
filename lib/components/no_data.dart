import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: kLightGrey.withOpacity(0.7),
            height: 100.h,
          ),
          SizedBox(height: 40.h),
          Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 140.h),
        ],
      ),
    );
  }
}
