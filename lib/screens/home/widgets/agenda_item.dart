import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/agenda.dart';

class AgendaItem extends StatelessWidget {
  const AgendaItem({
    Key? key,
    required this.agendamento,
  }) : super(key: key);

  final Agenda agendamento;

  @override
  Widget build(BuildContext context) {
    String tipoExame = opcoesAgenda[agendamento.tipo]['nome']!;
    switch (agendamento.tipo) {
      case 2:
        tipoExame = agendamento.tipoExame;
        break;
      case 3:
        tipoExame = agendamento.designacao ?? "";
    }
    final String especialidade = agendamento.tipo == 0 ? " de ${agendamento.especialidade}" : "";

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${agendamento.data.day}",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              meses[agendamento.data.month]['abrv']!,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 26.h,
          child: const VerticalDivider(color: Colors.white, thickness: 2),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$tipoExame$especialidade",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                agendamento.local,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
