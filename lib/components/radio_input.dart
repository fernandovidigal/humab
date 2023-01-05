import 'package:flutter/material.dart';
import 'package:humab/constants.dart';

import 'package:humab/helpers/screen_helper.dart';

class RadioInput extends StatelessWidget {
  final String title;
  final int index;
  final int valueSelected;
  final void Function(int? index)? onChange;
  final bool hasShadow;

  const RadioInput({
    Key? key,
    this.title = '',
    this.index = 0,
    this.valueSelected = 0,
    this.onChange,
    this.hasShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: hasShadow ? kShadow : [],
      ),
      child: Align(
        alignment: Alignment.center,
        child: RadioListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 20.sp),
          ),
          value: index,
          groupValue: valueSelected,
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: kPrimaryColor,
          onChanged: onChange,
        ),
      ),
    );
  }
}
