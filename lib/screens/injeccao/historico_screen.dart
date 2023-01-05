import 'package:flutter/material.dart';
import 'package:humab/components/small_primary_button.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/injecao.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/providers/injecao_provider.dart';
import 'package:humab/screens/injeccao/widgets/injecao_passada.dart';
import 'package:humab/screens/injeccao/widgets/injecoes_futuras.dart';
import 'package:humab/screens/injeccao/widgets/proxima_injecao.dart';
import 'package:provider/provider.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({Key? key}) : super(key: key);

  static const String routeName = '/historico';

  @override
  _HistoricoScreenState createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  final List<DateTime> futurasInjecoes = [];
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final InjecaoProvider injecaoProvider = Provider.of<InjecaoProvider>(context, listen: false);
    final DefinicoesProvider definicoesProvider = Provider.of<DefinicoesProvider>(context, listen: false);

    final List<Injecao> historico = injecaoProvider.getHistorico();
    final Injecao proximaInjecao = injecaoProvider.getProximaInjeccao();
    final int periodicidade = definicoesProvider.periodicidade;

    void _gerarFuturaInjecao() {
      DateTime dataFuturaInjecao;

      if (futurasInjecoes.isEmpty) {
        dataFuturaInjecao = proximaInjecao.data;
      } else {
        dataFuturaInjecao = futurasInjecoes.first;
      }

      futurasInjecoes.insert(
        0,
        dataFuturaInjecao.add(Duration(days: periodicidade == 0 ? 7 : 14)),
      );

      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 5), curve: Curves.easeOut);

      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico"),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              SmallPrimaryButton(
                text: "Ver Futuras Injeções",
                press: _gerarFuturaInjecao,
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InjecoesFuturas(text: "${futurasInjecoes[index].day} de ${meses[futurasInjecoes[index].month - 1]}"),
                        separatorBuilder: (context, index) => SizedBox(height: 12.h),
                        itemCount: futurasInjecoes.length,
                      ),
                      SizedBox(height: 12.h),
                      ProximaInjecao(
                        dia: "${proximaInjecao.data.day}",
                        mes: "${meses[proximaInjecao.data.month - 1]['abrv']}",
                        local: "${localInjeccao[proximaInjecao.local]['local']} ${localInjeccao[proximaInjecao.local]['lado']}",
                      ),
                      SizedBox(height: 12.h),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InjecaoPassada(
                          dia: "${historico[index].data.day}",
                          mes: "${meses[historico[index].data.month - 1]['abrv']}",
                          local: "${localInjeccao[historico[index].local]['local']} ${localInjeccao[historico[index].local]['lado']}",
                          lote: "${historico[index].nlote}",
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: 12.h),
                        itemCount: historico.length,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
