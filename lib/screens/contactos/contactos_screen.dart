import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:humab/components/no_data.dart';
import 'package:humab/components/slidable_item.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/models/contactos.dart';
import 'package:humab/providers/contactos_provider.dart';
import 'package:humab/screens/contactos/adicionar_contacto_screen.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/screens/contactos/editar_contacto_scren.dart';
import 'package:humab/screens/contactos/widgets/contactos_item.dart';
import 'package:provider/provider.dart';

class ContactosScreen extends StatefulWidget {
  const ContactosScreen({Key? key}) : super(key: key);

  static const String routeName = '/contactos';

  @override
  _ContactosScreenState createState() => _ContactosScreenState();
}

class _ContactosScreenState extends State<ContactosScreen> {
  final SlidableController _slideController = SlidableController();

  @override
  Widget build(BuildContext context) {
    final ContactosProvider _contactosProvider = Provider.of<ContactosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contactos"),
      ),
      body: SafeArea(
        child: Padding(
          padding: kAppPadding,
          child: FutureBuilder(
            future: _contactosProvider.getListaContactos(),
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
                return showLoading();
              }

              if (snapshot.hasError) {
                return showError();
              }

              List<Contactos> listaContactos = [];
              if (snapshot.hasData) {
                listaContactos = snapshot.data as List<Contactos>;
              }

              return listaContactos.isEmpty
                  ? const NoData(
                      icon: "assets/icons/phone.svg",
                      text: "Não existem contactos",
                    )
                  : ListView.separated(
                      itemCount: listaContactos.length + 1,
                      itemBuilder: (ctx, index) {
                        if (index == listaContactos.length) {
                          return SizedBox(height: 60.h);
                        }
                        return SlidableItem(
                          controller: _slideController,
                          child: ContactosItem(
                            contacto: listaContactos[index],
                          ),
                          editDialog: () {
                            Navigator.pushNamed(context, EditarContactoScreen.routeName, arguments: listaContactos[index]);
                          },
                          deleteDialog: () async {
                            Contactos deletedContacto = await Provider.of<ContactosProvider>(context).eliminarContacto(listaContactos[index]);
                            showSnackBar(context, deletedContacto);
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
        tooltip: "Adicionar Contacto",
        onPressed: () => Navigator.pushNamed(context, AdicionarContactoScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }

  showSnackBar(BuildContext context, Contactos contacto) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: const Text("Contacto eliminado"),
          action: SnackBarAction(
            label: "ANULAR",
            textColor: Colors.red,
            onPressed: () async {
              await Provider.of<ContactosProvider>(context, listen: false).adicionarContacto(contacto);
            },
          ),
        ),
      );
  }
}
