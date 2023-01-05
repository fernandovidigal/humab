import 'package:flutter/material.dart';
import 'package:humab/components/input_select_item.dart';
import 'package:humab/helpers/screen_helper.dart';

class OptionSelection extends StatelessWidget {
  const OptionSelection({Key? key, required this.listaOpcoes, required this.opcaoSelected, required this.updateFunction}) : super(key: key);

  final List<Map<String, String>> listaOpcoes;
  final int opcaoSelected;
  final ValueChanged<int> updateFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            listaOpcoes.length,
            (index) => InputSelectItem(
              svgIcon: listaOpcoes[index]['svgIcon']!,
              nome: listaOpcoes[index]['nome']!,
              selected: index == opcaoSelected ? true : false,
              press: () {
                updateFunction(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// press: () {
//                 setState(() {
//                   opcaoSelected = index;
//                 });
//               },
