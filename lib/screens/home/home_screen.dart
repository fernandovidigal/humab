import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/screens/agenda/agenda_screen.dart';
import 'package:humab/screens/contactos/contactos_screen.dart';
import 'package:humab/screens/definicoes/definicoes_screen.dart';
import 'package:humab/components/ad_banner.dart';
import 'package:humab/screens/home/cards/agenda_card.dart';
import 'package:humab/screens/home/cards/contactos_card.dart';
import 'package:humab/screens/home/cards/injeccao_card.dart';
import 'package:humab/screens/home/cards/notas_card.dart';
import 'package:humab/screens/injeccao/injeccao_screen.dart';
import 'package:humab/screens/notas/notas_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenHelper.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      mockpuSize: const Size(411, 731),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            iconSize: 28.w,
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(DefinicoesScreen.routeName),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: kAppPadding,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          InjeccaoCard(
                            press: () => Navigator.pushNamed(context, InjeccaoScreen.routeName),
                          ),
                          SizedBox(height: 20.w),
                          ContactosCard(
                            press: () => Navigator.pushNamed(context, ContactosScreen.routeName),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          NotasCard(
                            press: () => Navigator.pushNamed(context, NotasScreen.routeName),
                          ),
                          SizedBox(height: 20.w),
                          AgendaCard(
                            press: () => Navigator.pushNamed(context, AgendaScreen.routeName),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              const AdBanner(),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
