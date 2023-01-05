import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/theme.dart';

class IconInputField extends StatelessWidget {
  const IconInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.enabledBorder = true,
    required this.press,
    required this.icon,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool enabledBorder;
  final GestureTapCallback press;
  final Widget icon;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 18.sp),
      readOnly: true,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: kGreyColor,
          fontSize: 20.sp,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: icon,
        ),
        enabledBorder: enabledBorder ? underlineBorder() : InputBorder.none,
        focusedBorder: enabledBorder ? underlineBorder() : InputBorder.none,
        errorStyle: TextStyle(fontSize: 14.sp),
      ),
      onTap: press,
    );
  }
}
