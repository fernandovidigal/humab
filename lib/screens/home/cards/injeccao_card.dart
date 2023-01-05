import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/injecao.dart';
import 'package:humab/providers/injecao_provider.dart';
import 'package:provider/provider.dart';

class InjeccaoCard extends StatelessWidget {
  final GestureTapCallback? press;

  const InjeccaoCard({Key? key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Injecao injecao = Provider.of<InjecaoProvider>(context).getProximaInjeccao();
    final diasAtraso = daysBetween(injecao.data, DateTime.now());

    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: press,
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Injeção",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SvgPicture.asset("assets/icons/seringa.svg"),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatData(injecao.data),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (diasAtraso > 0)
                      Text(
                        "($diasAtraso dias atrasada)",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    SizedBox(height: 14.h),
                    Text(
                      "${localInjeccao[injecao.local]['local']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${localInjeccao[injecao.local]['lado']}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
