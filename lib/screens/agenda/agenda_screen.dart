import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:humab/components/no_data.dart';
import 'package:humab/components/slidable_item.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/models/agenda.dart';
import 'package:humab/providers/agenda_provider.dart';
import 'package:humab/screens/agenda/adicionar_agenda_screen.dart';
import 'package:humab/screens/agenda/editar_agenda_screen.dart';
import 'package:humab/screens/agenda/widgets/agendamento_item.dart';
import 'package:provider/provider.dart';
import 'package:humab/helpers/screen_helper.dart';

class AgendaScreen extends StatelessWidget {
  AgendaScreen({Key? key}) : super(key: key);
  static const String routeName = '/agenda';
  final SlidableController _slideController = SlidableController();

  @override
  Widget build(BuildContext context) {
    final AgendaProvider _agendaProvider = Provider.of<AgendaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
      ),
      body: SafeArea(
        child: Padding(
          padding: kAppPadding,
          child: FutureBuilder(
              future: _agendaProvider.getListaAgendamentos(),
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
                  return showLoading();
                }

                if (snapshot.hasError) {
                  return showError();
                }

                List<Agenda> listaAgendamentos = [];
                if (snapshot.hasData) {
                  listaAgendamentos = snapshot.data as List<Agenda>;
                }

                return listaAgendamentos.isEmpty
                    ? const NoData(
                        icon: "assets/icons/calendar.svg",
                        text: "Não existem agendamentos",
                      )
                    : ListView.separated(
                        itemCount: listaAgendamentos.length + 1,
                        itemBuilder: (ctx, index) {
                          if (index == listaAgendamentos.length) {
                            return SizedBox(height: 60.h);
                          }

                          return SlidableItem(
                            controller: _slideController,
                            child: AgendamentoItem(agendamento: listaAgendamentos[index]),
                            editDialog: () {
                              Navigator.of(context).pushNamed(EditarAgendaScreen.routeName, arguments: listaAgendamentos[index]);
                            },
                            deleteDialog: () async {
                              Agenda deletedAgendamento = await Provider.of<AgendaProvider>(context, listen: false).eliminarAgendamento(listaAgendamentos[index]);
                              showSnackBar(context, deletedAgendamento);
                            },
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 20.h),
                      );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        tooltip: "Adicionar Agendamento",
        onPressed: () => Navigator.of(context).pushNamed(
          AdicionarAgendaScreen.routeName,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  showSnackBar(BuildContext context, Agenda agendamento) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: const Text("Agendamento eliminado"),
          action: SnackBarAction(
            label: "ANULAR",
            textColor: Colors.red,
            onPressed: () async {
              await Provider.of<AgendaProvider>(context, listen: false).adicionarAgendamento(agendamento);
            },
          ),
        ),
      );
  }
}
