import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/helpers/screen_helper.dart';

class NotasCard extends StatelessWidget {
  final GestureTapCallback? press;

  const NotasCard({Key? key, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: press,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0XFF41D5E2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SvgPicture.asset("assets/icons/notes.svg"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
