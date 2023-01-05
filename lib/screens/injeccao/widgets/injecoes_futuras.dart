import 'package:flutter/material.dart';
import 'package:humab/components/list_item_bg.dart';
import 'package:humab/helpers/screen_helper.dart';

class InjecoesFuturas extends StatelessWidget {
  const InjecoesFuturas({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListItemBackground(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24.sp),
      ),
    );
  }
}
