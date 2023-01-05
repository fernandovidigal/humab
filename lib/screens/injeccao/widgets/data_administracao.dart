import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/helpers/screen_helper.dart';

class DataAdministracao extends StatelessWidget {
  const DataAdministracao({
    Key? key,
    required this.futuraInjecao,
    required this.press,
  }) : super(key: key);

  final DateTime futuraInjecao;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Próxima injecção a",
          style: TextStyle(
            fontSize: 14.sp,
            color: kGreyColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          formatData(futuraInjecao),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22.sp,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: press,
          child: Text(
            "Administrar aqui a injecção",
            style: TextStyle(color: kPrimaryColor, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
