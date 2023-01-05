import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/theme.dart';

class MultilineInputField extends StatelessWidget {
  const MultilineInputField({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.onSaved,
    this.enabledBorder = true,
    this.value,
    this.onTap,
    this.onFieldSubmitted,
  }) : super(key: key);

  final String labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool enabledBorder;
  final String? value;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      style: TextStyle(fontSize: 18.sp),
      validator: validator,
      onSaved: onSaved,
      initialValue: value,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: kGreyColor,
          fontSize: 20.sp,
        ),
        enabledBorder: enabledBorder ? underlineBorder() : InputBorder.none,
        focusedBorder: enabledBorder ? underlineBorder() : InputBorder.none,
        errorStyle: TextStyle(fontSize: 14.sp),
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
