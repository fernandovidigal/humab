import 'package:flutter/material.dart';
import 'package:humab/constants.dart';

import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/components/radio_input.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/screens/welcome/widgets/page_header.dart';
import 'package:provider/provider.dart';

class LocalAdministracaoPage extends StatefulWidget {
  const LocalAdministracaoPage({Key? key}) : super(key: key);

  @override
  _LocalAdministracaoPageState createState() => _LocalAdministracaoPageState();
}

class _LocalAdministracaoPageState extends State<LocalAdministracaoPage> {
  @override
  Widget build(BuildContext context) {
    final DefinicoesProvider _provider = Provider.of<DefinicoesProvider>(context);
    int valueSelected = _provider.localAdministracao;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(title: "Local", subtitle: "de administração da injecção"),
          SizedBox(height: 42.h),
          ...List.generate(
            opcoesLocalAdministracao.length,
            (index) => RadioInput(
              title: opcoesLocalAdministracao[index],
              index: index,
              valueSelected: valueSelected,
              onChange: (value) {
                _provider.localAdministracao = value ?? 0;
              },
            ),
          ),
        ],
      ),
    );
  }
}
