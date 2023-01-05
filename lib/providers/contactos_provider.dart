import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:humab/models/contactos.dart';

class ContactosProvider extends ChangeNotifier {
  late final Box<Contactos> _contactosDB;

  ContactosProvider();

  Future<void> loadDatabase() async {
    _contactosDB = await Hive.openBox<Contactos>('contactos', compactionStrategy: (int total, int deleted) {
      return deleted > 20;
    });
  }

  Future<List<Contactos>> getListaContactos() async {
    if (!Hive.isBoxOpen('contactos')) await loadDatabase();

    List<Contactos> _listaContactos = _contactosDB.values.toList();
    _listaContactos.sort((a, b) => a.nome.compareTo(b.nome));

    return _listaContactos;
  }

  Future<void> adicionarContacto(Contactos contacto) async {
    await _contactosDB.add(contacto);
    notifyListeners();
  }

  Future<void> actualizarContacto(Contactos contacto) async {
    await contacto.save();
    notifyListeners();
  }

  Future<Contactos> eliminarContacto(Contactos contacto) async {
    final Contactos removedContacto = Contactos(
      tipo: contacto.tipo,
      nome: contacto.nome,
      local: contacto.local,
      especialidade: contacto.especialidade,
      contacto: contacto.contacto,
      email: contacto.email,
    );

    await contacto.delete();
    notifyListeners();

    return removedContacto;
  }
}
