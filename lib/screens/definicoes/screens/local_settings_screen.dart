import 'package:flutter/material.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/components/radio_input.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:provider/provider.dart';

class LocalSettingsScreen extends StatefulWidget {
  const LocalSettingsScreen({Key? key}) : super(key: key);

  static const String routeName = '/localSettings';

  @override
  _LocalSettingsScreenState createState() => _LocalSettingsScreenState();
}

class _LocalSettingsScreenState extends State<LocalSettingsScreen> {
  int valueSelected = 0;

  @override
  void initState() {
    super.initState();
    valueSelected = Provider.of<DefinicoesProvider>(context, listen: false).localAdministracao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ...List.generate(
                    opcoesLocalAdministracao.length,
                    (index) => RadioInput(
                      title: opcoesLocalAdministracao[index],
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
                Provider.of<DefinicoesProvider>(context, listen: false).localAdministracao = valueSelected;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
