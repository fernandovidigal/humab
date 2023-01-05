import 'package:flutter/material.dart';
import 'package:humab/components/calendario.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/screens/agenda/widgets/list_wheel.dart';

showCalendarioBottomSheet({
  required BuildContext context,
  required DateTime calendarioDate,
  ValueChanged<DateTime>? calendarioValueChange,
  VoidCallback? onPress,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  "Escolha uma data",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                )
              ],
            ),
            SizedBox(height: 10.h),
            Calendario(
              valueChange: calendarioValueChange,
              initialDate: calendarioDate,
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              text: "Selecionar",
              press: onPress,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      );
    },
  );
}

showHoraBottomSheet({
  required BuildContext context,
  required TextEditingController horaTextController,
  required FixedExtentScrollController horasScrollController,
  required FixedExtentScrollController minutosScrollController,
  VoidCallback? onPress,
}) {
  final List<int> horas = List<int>.generate(24, (i) => i);
  final List<int> minutos = List<int>.generate(60, (i) => i);
  int initialHour = DateTime.now().hour;
  int initialMinutes = DateTime.now().minute;

  List<String> horaSplit = horaTextController.text.split("h");
  if (horaSplit.length == 2) {
    initialHour = int.parse(horaSplit.first);
    initialMinutes = int.parse(horaSplit.last);
  }

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  "Selecione uma hora",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListWheel(
                  controller: horasScrollController,
                  childlist: horas,
                  initialValue: initialHour,
                ),
                Text(
                  ":",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                  ),
                ),
                ListWheel(
                  controller: minutosScrollController,
                  childlist: minutos,
                  initialValue: initialMinutes,
                ),
              ],
            ),
            SizedBox(height: 30.h),
            PrimaryButton(
              text: "Selecionar",
              press: onPress,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      );
    },
  );
}
