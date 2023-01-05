import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:humab/components/ad_banner.dart';
import 'package:humab/components/input_field.dart';
import 'package:humab/components/input_select_item.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/contactos.dart';
import 'package:humab/providers/contactos_provider.dart';
import 'package:provider/provider.dart';

class EditarContactoScreen extends StatefulWidget {
  const EditarContactoScreen({Key? key}) : super(key: key);

  static const String routeName = '/editarContacto';

  @override
  State<EditarContactoScreen> createState() => _EditarContactoScreenState();
}

class _EditarContactoScreenState extends State<EditarContactoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int opcaoSelected = 0;
  final TextEditingController _nomeInputController = TextEditingController();
  final TextEditingController _localInputController = TextEditingController();
  final TextEditingController _especialidadeInputController = TextEditingController();
  final TextEditingController _contactoInputController = TextEditingController();
  final TextEditingController _emailInputController = TextEditingController();
  bool isInit = true;

  @override
  void dispose() {
    _nomeInputController.dispose();
    _localInputController.dispose();
    _especialidadeInputController.dispose();
    _contactoInputController.dispose();
    _emailInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Contactos contacto = ModalRoute.of(context)!.settings.arguments as Contactos;
    if (isInit) {
      opcaoSelected = contacto.tipo;
      _nomeInputController.text = contacto.nome;
      _localInputController.text = contacto.local;
      _especialidadeInputController.text = contacto.especialidade;
      _contactoInputController.text = contacto.contacto != null ? contacto.contacto.toString() : "";
      _emailInputController.text = contacto.email ?? "";
      isInit = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Contacto"),
      ),
      body: SafeArea(
        child: Padding(
          padding: kAppPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: kShadow,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...List.generate(
                                opcoesContactos.length,
                                (index) => InputSelectItem(
                                  svgIcon: opcoesContactos[index]['svgIcon']!,
                                  nome: opcoesContactos[index]['nome']!,
                                  selected: index == opcaoSelected ? true : false,
                                  press: () {
                                    setState(() {
                                      opcaoSelected = index;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFF0F0F0),
                          thickness: 1,
                        ),
                        InputField(
                          controller: _nomeInputController,
                          labelText: "Nome",
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Deve indicar o nome";
                            }
                            return null;
                          },
                        ),
                        InputField(
                          controller: _localInputController,
                          labelText: "Local",
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Deve indicar o local";
                            }
                            return null;
                          },
                        ),
                        InputField(
                          controller: _especialidadeInputController,
                          labelText: "Especialidade",
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Deve indicar a especialidade";
                            }
                            return null;
                          },
                        ),
                        InputField(
                          controller: _contactoInputController,
                          labelText: "Contacto Telefónico",
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            RegExp regExp = RegExp(r"[0-9]{9}");
                            if (value != null && value.isNotEmpty && !regExp.hasMatch(value)) {
                              return "Contacto telefónico inválido";
                            }
                            return null;
                          },
                        ),
                        InputField(
                          controller: _emailInputController,
                          labelText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          enabledBorder: false,
                          validator: (String? value) {
                            if (value != null && value.isNotEmpty && !EmailValidator.validate(value)) {
                              return "Endereço de email inválido";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                const AdBanner(),
                SizedBox(height: 20.h),
                PrimaryButton(
                  text: "Actualizar Contacto",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      contacto.tipo = opcaoSelected;
                      contacto.nome = _nomeInputController.text;
                      contacto.local = _localInputController.text;
                      contacto.especialidade = _especialidadeInputController.text;
                      contacto.contacto = _contactoInputController.text.isNotEmpty ? int.parse(_contactoInputController.text) : null;
                      contacto.email = _emailInputController.text.isNotEmpty ? _emailInputController.text : null;
                      await Provider.of<ContactosProvider>(context, listen: false).actualizarContacto(contacto);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
