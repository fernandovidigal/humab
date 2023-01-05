import 'package:flutter/material.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/components/radio_input.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:provider/provider.dart';

class PeriodicidadeSettingsScreen extends StatefulWidget {
  const PeriodicidadeSettingsScreen({Key? key}) : super(key: key);

  static const String routeName = '/periodicidadeSettings';

  @override
  _PeriodicidadeSettingsScreenState createState() => _PeriodicidadeSettingsScreenState();
}

class _PeriodicidadeSettingsScreenState extends State<PeriodicidadeSettingsScreen> {
  int valueSelected = 0;

  @override
  void initState() {
    super.initState();
    valueSelected = Provider.of<DefinicoesProvider>(context, listen: false).periodicidade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periodicidade'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ...List.generate(
                    opcoesPeriodicidade.length,
                    (index) => RadioInput(
                      title: opcoesPeriodicidade[index]['periodicidade'],
                      index: index,
                      valueSelected: valueSelected,
                      hasShadow: true,
                      onChange: (value) {
                        setState(() {
                          valueSelected = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            PrimaryButton(
                text: "Aplicar",
                press: () {
                  Provider.of<DefinicoesProvider>(context, listen: false).periodicidade = valueSelected;
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
