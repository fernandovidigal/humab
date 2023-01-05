import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/screens/definicoes/screens/genero_settings_screen.dart';
import 'package:humab/screens/definicoes/screens/local_settings_screen.dart';
import 'package:humab/screens/definicoes/screens/periodicidade_settings_screen.dart';
import 'package:humab/screens/definicoes/widgets/definicoes_item.dart';
import 'package:provider/provider.dart';

class DefinicoesScreen extends StatelessWidget {
  const DefinicoesScreen({Key? key}) : super(key: key);

  static const String routeName = '/definicoes';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<DefinicoesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Definições'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            DefinicoesItem(
              title: "Género",
              optionValue: opcoesGenero[settingsProvider.genero],
              press: () => Navigator.of(context).pushNamed(GeneroSettingsScreen.routeName),
            ),
            SizedBox(height: 20.h),
            DefinicoesItem(
              title: "Local",
              optionValue: opcoesLocalAdministracao[settingsProvider.localAdministracao],
              press: () => Navigator.of(context).pushNamed(LocalSettingsScreen.routeName),
            ),
            SizedBox(height: 20.h),
            DefinicoesItem(
              title: "Periodicidade",
              optionValue: opcoesPeriodicidade[settingsProvider.periodicidade]['periodicidade'],
              press: () => Navigator.of(context).pushNamed(PeriodicidadeSettingsScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
