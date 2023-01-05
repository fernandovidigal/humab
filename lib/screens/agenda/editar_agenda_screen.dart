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
import 'package:provider/provider.dart';
import 'package:humab/screens/agenda/helpers/agenda_functions.dart';

class EditarAgendaScreen extends StatefulWidget {
  const EditarAgendaScreen({Key? key}) : super(key: key);
  static const String routeName = '/editarAgenda';

  @override
  _EditarAgendaScreenState createState() => _EditarAgendaScreenState();
}

class _EditarAgendaScreenState extends State<EditarAgendaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dataInputController = TextEditingController();
  final TextEditingController _horaInputController = TextEditingController();
  final TextEditingController _designacaoInputController = TextEditingController();
  final TextEditingController _tipoExameInputController = TextEditingController();
  final TextEditingController _localInputController = TextEditingController();
  final TextEditingController _notasInputController = TextEditingController();
  final TextEditingController _especialidadeInputController = TextEditingController();
  FixedExtentScrollController horasScrollController = FixedExtentScrollController();
  FixedExtentScrollController minutosScrollController = FixedExtentScrollController();
  int opcaoSelected = 0;
  DateTime? dataSelected;
  bool isInit = true;

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
    _notasInputController.dispose();
    _especialidadeInputController.dispose();
    horasScrollController.dispose();
    minutosScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Agenda agendamento = ModalRoute.of(context)!.settings.arguments as Agenda;
    if (isInit) {
      dataSelected = agendamento.data;
      _dataInputController.text = formatData(agendamento.data);
      _horaInputController.text = agendamento.hora;
      opcaoSelected = agendamento.tipo;
      _tipoExameInputController.text = agendamento.tipoExame;
      _localInputController.text = agendamento.local;
      _especialidadeInputController.text = agendamento.especialidade ?? "";
      _designacaoInputController.text = agendamento.designacao ?? "";
      _notasInputController.text = agendamento.notas ?? "";
      isInit = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Agendamento"),
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
                            horasScrollController: horasScrollController,
                            minutosScrollController: minutosScrollController,
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
                  text: "Actualizar Agendamento",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      agendamento.tipo = opcaoSelected;
                      agendamento.data = dataSelected!;
                      agendamento.hora = _horaInputController.text;
                      agendamento.local = _localInputController.text;
                      agendamento.notas = _notasInputController.text.isNotEmpty ? _notasInputController.text : null;
                      agendamento.tipoExame = opcaoSelected != 2 ? opcoesAgenda[opcaoSelected]['nome']! : _tipoExameInputController.text;
                      switch (opcaoSelected) {
                        case 0:
                          saveAgendamentoConsulta(agendamento);
                          break;
                        case 2:
                          saveAgendamentoExames(agendamento);
                          break;
                        case 3:
                          saveAgendamentoOutros(agendamento);
                          break;
                      }
                      /*
                      agendamento.designacao = _designacaoInputController.text.isNotEmpty ? _designacaoInputController.text : null;
                      agendamento.especialidade = _especialidadeInputController.text.isNotEmpty ? _especialidadeInputController.text : null;*/
                      await Provider.of<AgendaProvider>(context, listen: false).actualizarAgendamento(agendamento);
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

  void saveAgendamentoConsulta(Agenda agendamento) {
    agendamento.designacao = null;
    agendamento.especialidade = _especialidadeInputController.text;
  }

  void saveAgendamentoExames(Agenda agendamento) {
    agendamento.designacao = null;
    agendamento.especialidade = null;
  }

  void saveAgendamentoOutros(Agenda agendamento) {
    agendamento.designacao = _designacaoInputController.text;
    agendamento.especialidade = null;
  }

  String _formatHoras() {
    final String hora = horasScrollController.selectedItem < 10 ? "0${horasScrollController.selectedItem.toString()}" : horasScrollController.selectedItem.toString();
    final String minuto = minutosScrollController.selectedItem < 10 ? "0${minutosScrollController.selectedItem.toString()}" : minutosScrollController.selectedItem.toString();

    return "${hora}h$minuto";
  }
}
