import 'package:flutter/material.dart';
import 'package:humab/components/ad_banner.dart';
import 'package:humab/components/input_field.dart';
import 'package:humab/components/multiline_input_field.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/notas.dart';
import 'package:humab/providers/notas_provider.dart';
import 'package:provider/provider.dart';

class AdicionarNotasScreen extends StatefulWidget {
  static const String routeName = '/adicionarNotas';

  const AdicionarNotasScreen({Key? key}) : super(key: key);

  @override
  _AdicionarNotasScreenState createState() => _AdicionarNotasScreenState();
}

class _AdicionarNotasScreenState extends State<AdicionarNotasScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloInputController = TextEditingController();
  final TextEditingController _notaInputController = TextEditingController();

  @override
  void dispose() {
    _tituloInputController.dispose();
    _notaInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Nota"),
      ),
      body: SafeArea(
        child: Padding(
          padding: kAppPadding,
          child: Column(
            children: [
              Expanded(
                child: Container(
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
                        InputField(
                          labelText: "Título",
                          controller: _tituloInputController,
                          textInputAction: TextInputAction.next,
                        ),
                        MultilineInputField(
                          labelText: "Nota",
                          controller: _notaInputController,
                          enabledBorder: false,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Deve escrever a nota";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const AdBanner(),
              SizedBox(height: 20.h),
              PrimaryButton(
                text: "Adicionar Nota",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    Notas nota = Notas(
                      data: DateTime.now(),
                      titulo: _tituloInputController.text.isNotEmpty ? _tituloInputController.text : null,
                      descricao: _notaInputController.text,
                    );
                    await Provider.of<NotasProvider>(context, listen: false).adicionarNota(nota);
                    Navigator.of(context).pop();
                  }
                },
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
