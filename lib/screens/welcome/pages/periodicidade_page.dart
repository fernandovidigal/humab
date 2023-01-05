import 'package:flutter/material.dart';
import 'package:humab/constants.dart';

import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/components/radio_input.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/screens/welcome/widgets/page_header.dart';
import 'package:provider/provider.dart';

class PeriodicidadePage extends StatefulWidget {
  const PeriodicidadePage({Key? key}) : super(key: key);

  @override
  _PeriodicidadePageState createState() => _PeriodicidadePageState();
}

class _PeriodicidadePageState extends State<PeriodicidadePage> {
  @override
  Widget build(BuildContext context) {
    final DefinicoesProvider _provider = Provider.of<DefinicoesProvider>(context);
    int valueSelected = _provider.periodicidade;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(title: "Periodicidade", subtitle: "de administração da injecção"),
          SizedBox(height: 42.h),
          ...List.generate(
            opcoesPeriodicidade.length,
            (index) => RadioInput(
              title: opcoesPeriodicidade[index]['periodicidade'],
              index: index,
              valueSelected: valueSelected,
              onChange: (value) {
                _provider.periodicidade = value ?? 0;
              },
            ),
          ),
        ],
      ),
    );
  }
}
