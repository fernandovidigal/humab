import 'package:flutter/material.dart';
import 'package:humab/constants.dart';

import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/components/radio_input.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/screens/welcome/widgets/page_header.dart';
import 'package:provider/provider.dart';

class GeneroPage extends StatefulWidget {
  const GeneroPage({Key? key}) : super(key: key);

  @override
  _GeneroPageState createState() => _GeneroPageState();
}

class _GeneroPageState extends State<GeneroPage> {
  @override
  Widget build(BuildContext context) {
    final DefinicoesProvider _provider = Provider.of<DefinicoesProvider>(context);
    int valueSelected = _provider.genero;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(title: "Género"),
          SizedBox(height: 42.h),
          ...List.generate(
            opcoesGenero.length,
            (index) => RadioInput(
              title: opcoesGenero[index],
              index: index,
              valueSelected: valueSelected,
              onChange: (value) {
                _provider.genero = value ?? 0;
              },
            ),
          ),
        ],
      ),
    );
  }
}
