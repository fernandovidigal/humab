import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/agenda.dart';
import 'package:humab/providers/agenda_provider.dart';
import 'package:humab/screens/home/widgets/agenda_item.dart';
import 'package:provider/provider.dart';

class AgendaCard extends StatefulWidget {
  final GestureTapCallback? press;

  const AgendaCard({Key? key, this.press}) : super(key: key);

  @override
  State<AgendaCard> createState() => _AgendaCardState();
}

class _AgendaCardState extends State<AgendaCard> {
  @override
  Widget build(BuildContext context) {
    final AgendaProvider _agendaProvider = Provider.of<AgendaProvider>(context);

    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: widget.press,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0XFFFFC405),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Agenda",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/calendar.svg",
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                const Spacer(),
                FutureBuilder(
                  future: _agendaProvider.getAgendamentosIniciais(count: 3),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      );
                    }

                    List<Agenda> listaAgendamentos = [];
                    if (snapshot.hasData) {
                      listaAgendamentos = snapshot.data as List<Agenda>;
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => AgendaItem(
                        agendamento: listaAgendamentos[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 16.h),
                      itemCount: listaAgendamentos.length,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
