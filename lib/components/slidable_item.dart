import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

class SlidableItem extends StatelessWidget {
  const SlidableItem({
    Key? key,
    required this.editDialog,
    required this.deleteDialog,
    required this.child,
    this.controller,
  }) : super(key: key);

  final Widget child;
  final SlidableController? controller;
  final VoidCallback? editDialog;
  final VoidCallback? deleteDialog;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: controller,
      actionPane: const SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 30.w, top: 6.w, bottom: 6.w),
          child: SlideAction(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kBlue.withOpacity(0.15),
            ),
            child: SvgPicture.asset("assets/icons/editar.svg"),
            onTap: editDialog,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, top: 6.w, bottom: 6.w),
          child: SlideAction(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor.withOpacity(0.15),
            ),
            child: SvgPicture.asset("assets/icons/eliminar.svg"),
            onTap: deleteDialog,
            closeOnTap: false,
          ),
        ),
      ],
      child: child,
    );
  }
}
