import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:humab/components/no_data.dart';
import 'package:humab/components/slidable_item.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/models/notas.dart';
import 'package:humab/providers/notas_provider.dart';
import 'package:humab/screens/notas/adicionar_notas_screen.dart';
import 'package:humab/screens/notas/editar_notas_screen.dart';
import 'package:humab/screens/notas/widgets/slidable_content.dart';
import 'package:provider/provider.dart';
import 'package:humab/helpers/screen_helper.dart';

class NotasScreen extends StatefulWidget {
  static const String routeName = '/notas';

  const NotasScreen({Key? key}) : super(key: key);

  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final SlidableController _slideController = SlidableController();

  @override
  Widget build(BuildContext context) {
    final NotasProvider _notasProvider = Provider.of<NotasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notas"),
      ),
      body: SafeArea(
        child: Padding(
          padding: kAppPadding,
          child: FutureBuilder(
            future: _notasProvider.getListaNotas(),
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
                return showLoading();
              }

              if (snapshot.hasError) {
                return showError();
              }

              List<Notas> listaNotas = [];
              if (snapshot.hasData) {
                listaNotas = snapshot.data as List<Notas>;
              }

              return listaNotas.isEmpty
                  ? const NoData(
                      icon: "assets/icons/notes.svg",
                      text: "Não existem notas",
                    )
                  : ListView.separated(
                      itemCount: listaNotas.length + 1,
                      itemBuilder: (ctx, index) {
                        if (index == listaNotas.length) {
                          return SizedBox(height: 60.h);
                        }
                        return SlidableItem(
                          controller: _slideController,
                          child: SlidableContent(nota: listaNotas[index]),
                          editDialog: () {
                            Navigator.of(context).pushNamed(EditarNotasScreen.routeName, arguments: listaNotas[index]);
                          },
                          deleteDialog: () async {
                            Notas deletedNota = await Provider.of<NotasProvider>(context, listen: false).eliminarNota(listaNotas[index]);
                            showSnackBar(context, deletedNota);
                          },
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 20.h),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        tooltip: "Adicionar Nota",
        onPressed: () => Navigator.pushNamed(context, AdicionarNotasScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }

  showSnackBar(BuildContext context, Notas nota) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: const Text("Nota eliminada"),
          action: SnackBarAction(
            label: "ANULAR",
            textColor: Colors.red,
            onPressed: () async {
              await Provider.of<NotasProvider>(context, listen: false).adicionarNota(nota);
            },
          ),
        ),
      );
  }
}
