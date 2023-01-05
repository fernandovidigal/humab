import 'package:flutter/material.dart';
import 'package:humab/helpers/screen_helper.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle ?? '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
