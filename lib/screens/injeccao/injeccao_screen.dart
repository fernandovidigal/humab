import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/injecao.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/providers/injecao_provider.dart';
import 'package:humab/screens/injeccao/historico_screen.dart';
import 'package:humab/screens/injeccao/widgets/administracao_injecao_form.dart';
import 'package:humab/screens/injeccao/widgets/data_administracao.dart';
import 'package:humab/screens/injeccao/widgets/local_injeccao.dart';
import 'package:provider/provider.dart';

class InjeccaoScreen extends StatefulWidget {
  static const String routeName = '/injeccao';

  const InjeccaoScreen({Key? key}) : super(key: key);

  @override
  _InjeccaoScreenState createState() => _InjeccaoScreenState();
}

class _InjeccaoScreenState extends State<InjeccaoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int selectedLocal = 0;
  bool localHaveChanged = false;
  bool localDiferenteInjecao = false;
  String? nLote;

  @override
  Widget build(BuildContext context) {
    final InjecaoProvider injecaoProvider = Provider.of<InjecaoProvider>(context);
    final DefinicoesProvider definicoesProvider = Provider.of<DefinicoesProvider>(context);

    final Injecao _proximaInjecao = injecaoProvider.getProximaInjeccao();
    final int _localAdministracao = injecaoProvider.getLocalAdministracao();
    final DateTime _dataFuturaInjecao = injecaoProvider.getDataFuturaInjeccao();
    final _diasAtraso = daysBetween(_proximaInjecao.data, DateTime.now());

    if (!localHaveChanged) {
      selectedLocal = _localAdministracao;
    }

    bool mostrarInjecaoForm = (_proximaInjecao.isToday() || _diasAtraso > 0 && (selectedLocal == _localAdministracao)) ? true : false;

    if (localDiferenteInjecao) {
      mostrarInjecaoForm = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Injecção"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(HistoricoScreen.routeName),
            icon: Icon(
              Icons.date_range,
              size: 30.w,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: ScreenHelper().screenHeight - (ScreenHelper().statusBarHeight + AppBar().preferredSize.height),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -70.h,
                right: 0,
                left: 0,
                bottom: 60.h,
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    definicoesProvider.genero == 0 ? 'assets/homem.svg' : 'assets/mulher.svg',
                    height: 836.h,
                    width: 331.w,
                  ),
                ),
              ),
              if (_localAdministracao != 2)
                Positioned(
                  top: 120.h,
                  left: 165.w,
                  child: LocalInjeccao(
                    selected: selectedLocal == 0 ? true : false,
                    press: () {
                      setState(() {
                        selectedLocal = 0;
                        localHaveChanged = true;
                      });
                    },
                  ),
                ),
              if (_localAdministracao != 2)
                Positioned(
                  top: 120.h,
                  right: 165.w,
                  child: LocalInjeccao(
                    selected: selectedLocal == 1 ? true : false,
                    press: () {
                      setState(() {
                        selectedLocal = 1;
                        localHaveChanged = true;
                      });
                    },
                  ),
                ),
              if (_localAdministracao != 1)
                Positioned(
                  top: 225.h,
                  left: 157.w,
                  child: LocalInjeccao(
                    large: true,
                    selected: selectedLocal == 2 ? true : false,
                    press: () {
                      setState(() {
                        selectedLocal = 2;
                        localHaveChanged = true;
                      });
                    },
                  ),
                ),
              if (_localAdministracao != 1)
                Positioned(
                  top: 225.h,
                  right: 157.w,
                  child: LocalInjeccao(
                    large: true,
                    selected: selectedLocal == 3 ? true : false,
                    press: () {
                      setState(() {
                        selectedLocal = 3;
                        localHaveChanged = true;
                      });
                    },
                  ),
                ),
              Positioned(
                bottom: 140.h,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 140.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kPrimaryColor,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: kShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${localInjeccao[_proximaInjecao.local]['local']}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 28.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "${localInjeccao[_proximaInjecao.local]['lado']}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30.h,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 346.w,
                    //height: mostrarInjecaoForm ? 100.h : 85.h,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: kShadow,
                    ),
                    child: mostrarInjecaoForm
                        ? AdministracaoInjecaoForm(
                            formKey: _formKey,
                            injecao: _proximaInjecao,
                            saved: (value) {
                              nLote = value;
                            },
                            press: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                injecaoProvider.registarInjecao(int.parse(nLote!), selectedLocal);
                                // if (definicoesProvider.localAdministracao ==
                                //     0) {
                                //   Navigator.of(context).pushReplacementNamed(
                                //       SelecionaFuturaInjecaoScreen.routeName);
                                // }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Deve indicar o nº de lote',
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        : DataAdministracao(
                            futuraInjecao: _diasAtraso < 0 ? _proximaInjecao.data : _dataFuturaInjecao,
                            press: () => setState(() {
                              localDiferenteInjecao = true;
                            }),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
