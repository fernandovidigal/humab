import 'package:flutter/material.dart';
import 'package:humab/helpers/screen_helper.dart';

class ListWheel extends StatefulWidget {
  const ListWheel({
    Key? key,
    required this.controller,
    required this.childlist,
    required this.initialValue,
  }) : super(key: key);

  final FixedExtentScrollController controller;
  final List<int> childlist;
  final int initialValue;

  @override
  State<ListWheel> createState() => _ListWheelState();
}

class _ListWheelState extends State<ListWheel> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.controller.animateToItem(
        widget.initialValue,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      width: 70.w,
      child: ListWheelScrollView(
        controller: widget.controller,
        itemExtent: 30,
        diameterRatio: 1.05,
        useMagnifier: true,
        magnification: 1.35,
        squeeze: 1,
        overAndUnderCenterOpacity: 0.15,
        perspective: 0.003,
        physics: const FixedExtentScrollPhysics(),
        children: [
          ...widget.childlist
              .map((hora) => Text(
                    hora < 10 ? "0$hora" : "$hora",
                    style: TextStyle(fontSize: 30.sp),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
