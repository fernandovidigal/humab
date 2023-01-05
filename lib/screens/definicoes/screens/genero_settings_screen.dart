import 'package:flutter/material.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/components/radio_input.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:provider/provider.dart';

class GeneroSettingsScreen extends StatefulWidget {
  const GeneroSettingsScreen({Key? key}) : super(key: key);

  static const String routeName = '/generoSettings';

  @override
  _GeneroSettingsScreenState createState() => _GeneroSettingsScreenState();
}

class _GeneroSettingsScreenState extends State<GeneroSettingsScreen> {
  int valueSelected = 0;

  @override
  void initState() {
    super.initState();
    valueSelected = Provider.of<DefinicoesProvider>(context, listen: false).genero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Género"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ...List.generate(
                    opcoesGenero.length,
                    (index) => RadioInput(
                      title: opcoesGenero[index],
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
                  Provider.of<DefinicoesProvider>(context, listen: false).genero = valueSelected;
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
