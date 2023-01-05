import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class DateInputField extends StatelessWidget {
  final TextEditingController? controller;
  final GestureTapCallback? tap;

  const DateInputField({Key? key, this.controller, this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 20.sp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.w),
        hintText: "Selecione uma data",
        filled: true,
        fillColor: Colors.white,
        suffixIcon: const Icon(
          Icons.calendar_today_sharp,
          color: kGreyColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      readOnly: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Deve selecionar a hora";
        }
        return null;
      },
      onTap: tap,
    );
  }
}
