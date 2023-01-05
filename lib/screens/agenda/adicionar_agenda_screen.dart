import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:humab/components/ad_banner.dart';
import 'package:humab/components/icon_input_field.dart';
import 'package:humab/components/input_field.dart';
import 'package:humab/components/multiline_input_field.dart';
import 'package:humab/components/option_selection.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/agenda.dart';
import 'package:humab/providers/agenda_provider.dart';
import 'package:humab/screens/agenda/helpers/agenda_functions.dart';
import 'package:provider/provider.dart';

class AdicionarAgendaScreen extends StatefulWidget {
  const AdicionarAgendaScreen({Key? key}) : super(key: key);
  static const String routeName = '/adicionarAgenda';

  @override
  _AdicionarAgendaScreenState createState() => _AdicionarAgendaScreenState();
}

class _AdicionarAgendaScreenState extends State<AdicionarAgendaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dataInputController = TextEditingController();
  final TextEditingController _horaInputController = TextEditingController();
  final TextEditingController _designacaoInputController = TextEditingController();
  final TextEditingController _tipoExameInputController = TextEditingController();
  final TextEditingController _localInputController = TextEditingController();
  final TextEditingController _notasInputController = TextEditingController();
  final TextEditingController _especialidadeInputController = TextEditingController();
  final FixedExtentScrollController _horasScrollController = FixedExtentScrollController();
  final FixedExtentScrollController _minutosScrollController = FixedExtentScrollController();
  int opcaoSelected = 0;
  DateTime? dataSelected;

  void _updateSelectedData(DateTime data) {
    dataSelected = data;
  }

  void _updateSelection(int selection) {
    setState(() {
      opcaoSelected = selection;
      _formKey.currentState!.reset();
    });
  }

  @override
  void dispose() {
    _dataInputController.dispose();
    _horaInputController.dispose();
    _designacaoInputController.dispose();
    _tipoExameInputController.dispose();
    _localInputController.dispose();
    _especialidadeInputController.dispose();
    _notasInputController.dispose();
    _horasScrollController.dispose();
    _minutosScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar à Agenda"),
      ),
      body: Padding(
        padding: kAppPadding,
        child: SafeArea(
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
                        OptionSelection(
                          listaOpcoes: opcoesAgenda,
                          opcaoSelected: opcaoSelected,
                          updateFunction: _updateSelection,
                        ),
                        const Divider(
                          color: Color(0xFFF0F0F0),
                          thickness: 1,
                        ),
                        IconInputField(
                          controller: _dataInputController,
                          label: "Data",
                          icon: const Icon(
                            Icons.calendar_today_sharp,
                            color: kGreyColor,
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Deve indicar a data";
                            }
                            return null;
                          },
                          press: () => showCalendarioBottomSheet(
                            context: context,
                            calendarioDate: dataSelected ?? DateTime.now(),
                            calendarioValueChange: _updateSelectedData,
                            onPress: () {
                              dataSelected ??= DateTime.now();
                              _dataInputController.text = formatData(dataSelected!);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        IconInputField(
                          controller: _horaInputController,
                          label: "Hora",
                          icon: const Icon(
                            Icons.access_time,
                            color: kGreyColor,
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Deve indicar a hora";
                            }
                            return null;
                          },
                          press: () => showHoraBottomSheet(
                            context: context,
                            horaTextController: _horaInputController,
                            horasScrollController: _horasScrollController,
                            minutosScrollController: _minutosScrollController,
                            onPress: () {
                              _horaInputController.text = _formatHoras();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        if (opcaoSelected == 0)
                          InputField(
                            labelText: "Especialidade",
                            controller: _especialidadeInputController,
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Deve indicar a especialidade";
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
                        if (opcaoSelected == 2)
                          InputField(
                            controller: _tipoExameInputController,
                            labelText: "Tipo de Exame",
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Deve indicar o tipo de exame";
                              }
                              return null;
                            },
                          ),
                        if (opcaoSelected == (opcoesAgenda.length - 1))
                          InputField(
                            controller: _designacaoInputController,
                            labelText: "Designação",
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Deve indicar a designação";
                              }
                              return null;
                            },
                          ),
                        MultilineInputField(
                          controller: _notasInputController,
                          labelText: "Notas",
                          enabledBorder: false,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                const AdBanner(),
                SizedBox(height: 20.h),
                PrimaryButton(
                  text: "Adicionar à Agenda",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      Agenda agendamento = Agenda(
                        data: dataSelected!,
                        hora: _horaInputController.text,
                        tipo: opcaoSelected,
                        especialidade: _especialidadeInputController.text.isNotEmpty ? _especialidadeInputController.text : null,
                        tipoExame: opcaoSelected != 2 ? opcoesAgenda[opcaoSelected]['nome']! : _tipoExameInputController.text,
                        local: _localInputController.text,
                        designacao: _designacaoInputController.text.isNotEmpty ? _designacaoInputController.text : null,
                        notas: _notasInputController.text.isNotEmpty ? _notasInputController.text : null,
                      );
                      await Provider.of<AgendaProvider>(context, listen: false).adicionarAgendamento(agendamento);
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

  String _formatHoras() {
    final String hora = _horasScrollController.selectedItem < 10 ? "0${_horasScrollController.selectedItem.toString()}" : _horasScrollController.selectedItem.toString();
    final String minuto = _minutosScrollController.selectedItem < 10 ? "0${_minutosScrollController.selectedItem.toString()}" : _minutosScrollController.selectedItem.toString();

    return "${hora}h$minuto";
  }
}
