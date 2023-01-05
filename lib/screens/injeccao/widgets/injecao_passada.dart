import 'package:flutter/material.dart';
import 'package:humab/components/list_item_bg.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class InjecaoPassada extends StatelessWidget {
  const InjecaoPassada({
    Key? key,
    required this.dia,
    required this.mes,
    required this.local,
    required this.lote,
  }) : super(key: key);

  final String dia;
  final String mes;
  final String local;
  final String lote;

  @override
  Widget build(BuildContext context) {
    return ListItemBackground(
      padding: 10.w,
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dia,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  mes,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local,
                style: TextStyle(fontSize: 20.sp),
              ),
              Text(
                "Lote: $lote",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: kGreyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
