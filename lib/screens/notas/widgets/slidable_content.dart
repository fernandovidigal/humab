import 'package:flutter/material.dart';
import 'package:humab/components/list_item_bg.dart';
import 'package:humab/constants.dart';
import 'package:humab/models/notas.dart';
import 'package:humab/helpers/screen_helper.dart';

class SlidableContent extends StatelessWidget {
  const SlidableContent({
    Key? key,
    required this.nota,
  }) : super(key: key);

  final Notas nota;

  @override
  Widget build(BuildContext context) {
    return ListItemBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${nota.data.day} de ${meses[nota.data.month - 1]['mes']} de ${nota.data.year}",
            style: TextStyle(
              fontSize: 12.sp,
              color: kGreyColor,
            ),
          ),
          SizedBox(height: 5.h),
          if (nota.titulo != null)
            Text(
              nota.titulo ?? "",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(height: nota.titulo != null ? 10.h : 5.h),
          Text(
            nota.descricao,
            style: const TextStyle(height: 1.3),
          ),
        ],
      ),
    );
  }
}
