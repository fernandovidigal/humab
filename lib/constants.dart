import 'package:flutter/material.dart';
import 'package:humab/helpers/screen_helper.dart';

const kPrimaryColor = Color(0XFFFF5668);
const kSecondaryColor = Color(0XFF3EA5EC);
const kSecondaryLightColor = Color(0xFFEBF6FD);
const kBackgroundColor = Color(0xFFF7F8FB);
//final kBackgroundColor = Color(0xFFFDFAF9);
const kTextColor = Color(0XFF000000);
const kGreyColor = Color(0XFFA6B0B8);
const kLightGrey = Color(0XFFE3E3E3);
const kLightBlue = Color(0XFFEBF6FD);
const kBlue = Color(0XFF3EA5EC);
const kBlack = Color(0XFF212121);

EdgeInsetsGeometry kAppPadding = EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h);

/*List<BoxShadow> kShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.05),
    offset: Offset(0, 2),
    blurRadius: 14.r,
  ),
];*/

List<BoxShadow> kShadow = [
  BoxShadow(
    color: Colors.grey.shade200,
    offset: const Offset(5, 10),
    blurRadius: 15.r,
  ),
];

final List<Map<String, String>> meses = [
  {'mes': 'Janeiro', 'abrv': 'Jan'},
  {'mes': 'Fevereiro', 'abrv': 'Fev'},
  {'mes': 'Março', 'abrv': 'Mar'},
  {'mes': 'Abril', 'abrv': 'Abr'},
  {'mes': 'Maio', 'abrv': 'Mai'},
  {'mes': 'Junho', 'abrv': 'Jun'},
  {'mes': 'Julho', 'abrv': 'Jul'},
  {'mes': 'Agosto', 'abrv': 'Ago'},
  {'mes': 'Setembro', 'abrv': 'Set'},
  {'mes': 'Outubro', 'abrv': 'Out'},
  {'mes': 'Novembro', 'abrv': 'Nov'},
  {'mes': 'Dezembro', 'abrv': 'Dez'},
];

final List<Map<String, String>> opcoesAgenda = [
  {
    "svgIcon": "assets/icons/medico.svg",
    "nome": "Consulta",
  },
  {
    "svgIcon": "assets/icons/blood.svg",
    "nome": "Análises",
  },
  {
    "svgIcon": "assets/icons/exames.svg",
    "nome": "Exames",
  },
  {
    "svgIcon": "assets/icons/outros.svg",
    "nome": "Outros",
  }
];

final List<Map<String, String>> opcoesContactos = [
  {
    "svgIcon": "assets/icons/medico.svg",
    "nome": "Médico(a)",
  },
  {
    "svgIcon": "assets/icons/enfermeiro.svg",
    "nome": "Enfermeiro(a)",
  },
  {
    "svgIcon": "assets/icons/farmaceutico.svg",
    "nome": "Farmacêutico(a)",
  },
];

final List<String> opcoesGenero = ["Masculino", "Feminino"];

final List<String> opcoesLocalAdministracao = ["Barriga e Pernas", "Barriga", "Pernas"];

final List<Map<String, String>> localInjeccao = [
  {'local': 'Barriga', 'lado': 'Lado Direito'},
  {'local': 'Barriga', 'lado': 'Lado Esquerdo'},
  {'local': 'Perna', 'lado': 'Lado Direito'},
  {'local': 'Perna', 'lado': 'Lado Esquerdo'},
];

final List<Map<String, dynamic>> opcoesPeriodicidade = [
  {'periodicidade': "Todas as Semanas", 'dias': 7},
  {'periodicidade': "Semanas Alternadas", 'dias': 14}
];
