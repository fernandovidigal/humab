import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class InputSelectItem extends StatelessWidget {
  const InputSelectItem({
    Key? key,
    required this.svgIcon,
    required this.nome,
    required this.press,
    this.selected = false,
  }) : super(key: key);

  final String svgIcon;
  final String nome;
  final GestureTapCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11.w),
            width: 46.w,
            height: 46.w,
            decoration: selected ? buildSelectedBoxDecoration() : buildUnselectedBoxDecoration(),
            child: SvgPicture.asset(
              svgIcon,
              color: selected ? Colors.white : kGreyColor.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            nome,
            style: TextStyle(
              color: selected ? kTextColor : kGreyColor.withOpacity(0.5),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildUnselectedBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: kGreyColor.withOpacity(0.5),
      ),
    );
  }

  BoxDecoration buildSelectedBoxDecoration() {
    return const BoxDecoration(
      shape: BoxShape.circle,
      color: kPrimaryColor,
    );
  }
}
