import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/components/list_item_bg.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/agenda.dart';

class AgendamentoItem extends StatelessWidget {
  const AgendamentoItem({Key? key, required this.agendamento}) : super(key: key);

  final Agenda agendamento;

  @override
  Widget build(BuildContext context) {
    String tipoExame = opcoesAgenda[agendamento.tipo]['nome']!;
    switch (agendamento.tipo) {
      case 2:
        tipoExame = agendamento.tipoExame;
        break;
      case 3:
        tipoExame = agendamento.designacao ??= "";
    }
    final String especialidade = agendamento.tipo == 0 ? " de ${agendamento.especialidade}" : "";
    final bool existemNotas = agendamento.notas != null && agendamento.notas!.isNotEmpty;

    return ListItemBackground(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(9.w),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(opcoesAgenda[agendamento.tipo]['svgIcon']!),
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatData(agendamento.data),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "$tipoExame$especialidade",
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      agendamento.local,
                      style: TextStyle(
                        color: const Color(0xFFA5A5A5),
                        fontSize: 13.sp,
                      ),
                    ),
                    if (existemNotas) SizedBox(height: 18.h),
                    if (existemNotas)
                      const Text(
                        "Notas:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    if (existemNotas) SizedBox(height: 6.h),
                    if (existemNotas)
                      Text(
                        agendamento.notas.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: kLightBlue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      agendamento.hora,
                      style: TextStyle(
                        color: kBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
