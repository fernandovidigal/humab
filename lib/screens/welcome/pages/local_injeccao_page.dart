import 'package:flutter/material.dart';

import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/components/radio_input.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/screens/welcome/widgets/page_header.dart';
import 'package:provider/provider.dart';

class LocalInjeccaoPage extends StatefulWidget {
  const LocalInjeccaoPage({Key? key}) : super(key: key);

  @override
  _LocalInjeccaoPageState createState() => _LocalInjeccaoPageState();
}

class _LocalInjeccaoPageState extends State<LocalInjeccaoPage> {
  @override
  Widget build(BuildContext context) {
    final DefinicoesProvider _provider = Provider.of<DefinicoesProvider>(context);
    int valueSelected = _provider.localInjeccao;
    int localAdministracao = _provider.localAdministracao;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(title: "Local", subtitle: "da próxima injecção"),
          SizedBox(height: 42.h),
          if (localAdministracao != 2)
            RadioInput(
              title: 'Barriga Lado Direito',
              index: 0,
              valueSelected: valueSelected,
              onChange: (value) {
                _provider.localInjeccao = value ?? 0;
              },
            ),
          if (localAdministracao != 2)
            RadioInput(
              title: 'Barriga Lado Esquerdo',
              index: 1,
              valueSelected: valueSelected,
              onChange: (value) {
                _provider.localInjeccao = value ?? 1;
              },
            ),
          if (localAdministracao != 1)
            RadioInput(
              title: 'Perna Lado Direito',
              index: 2,
              valueSelected: valueSelected,
              onChange: (value) {
                _provider.localInjeccao = value ?? 2;
              },
            ),
          if (localAdministracao != 1)
            RadioInput(
              title: 'Perna Lado Esquerdo',
              index: 3,
              valueSelected: valueSelected,
              onChange: (value) {
                _provider.localInjeccao = value ?? 3;
              },
            ),
        ],
      ),
    );
  }
}
