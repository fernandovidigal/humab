import 'package:flutter/material.dart';
import 'package:humab/helpers/screen_helper.dart';

class VoltarButton extends StatelessWidget {
  final GestureTapCallback? press;

  const VoltarButton({Key? key, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Text(
        "Voltar",
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
