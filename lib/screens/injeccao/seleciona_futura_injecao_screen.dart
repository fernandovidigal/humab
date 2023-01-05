import 'package:flutter/material.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/components/radio_input.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/helpers/welcome_helper.dart';

class SelecionaFuturaInjecaoScreen extends StatefulWidget {
  const SelecionaFuturaInjecaoScreen({Key? key}) : super(key: key);

  static const String routeName = '/selecionaFuturaInjecao';

  @override
  _SelecionaFuturaInjecaoScreenState createState() => _SelecionaFuturaInjecaoScreenState();
}

class _SelecionaFuturaInjecaoScreenState extends State<SelecionaFuturaInjecaoScreen> {
  int valueSelected = (WelcomeHelper.instance.localInjeccao + 1 >= localInjeccao.length) ? 0 : WelcomeHelper.instance.localInjeccao + 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Injeção Administrada"),
            SizedBox(height: 30.h),
            const Text("Selecione o próximo local de administração"),
            SizedBox(height: 10.h),
            Expanded(
              child: Column(
                children: [
                  RadioInput(
                    title: 'Barriga Lado Direito',
                    index: 0,
                    valueSelected: valueSelected,
                    onChange: (value) {
                      WelcomeHelper.instance.localInjeccao = value ?? 0;
                      setState(() {
                        valueSelected = value ?? 0;
                      });
                    },
                  ),
                  RadioInput(
                    title: 'Barriga Lado Esquerdo',
                    index: 1,
                    valueSelected: valueSelected,
                    onChange: (value) {
                      WelcomeHelper.instance.localInjeccao = value ?? 1;
                      setState(() {
                        valueSelected = value ?? 0;
                      });
                    },
                  ),
                  RadioInput(
                    title: 'Perna Lado Direito',
                    index: 2,
                    valueSelected: valueSelected,
                    onChange: (value) {
                      WelcomeHelper.instance.localInjeccao = value ?? 2;
                      setState(() {
                        valueSelected = value ?? 0;
                      });
                    },
                  ),
                  RadioInput(
                    title: 'Perna Lado Esquerdo',
                    index: 3,
                    valueSelected: valueSelected,
                    onChange: (value) {
                      WelcomeHelper.instance.localInjeccao = value ?? 3;
                      setState(() {
                        valueSelected = value ?? 0;
                      });
                    },
                  ),
                ],
              ),
            ),
            PrimaryButton(text: "Selecionar", press: () {}),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
