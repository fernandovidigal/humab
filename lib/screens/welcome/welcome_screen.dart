import 'package:flutter/material.dart';
import 'package:humab/constants.dart';

import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/injecao.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/providers/injecao_provider.dart';
import 'package:humab/screens/home/home_screen.dart';
import 'package:humab/screens/welcome/pages/genero_page.dart';
import 'package:humab/screens/welcome/pages/local_administracao_page.dart';
import 'package:humab/screens/welcome/pages/local_injeccao_page.dart';
import 'package:humab/screens/welcome/pages/periodicidade_page.dart';
import 'package:humab/screens/welcome/pages/proxima_data_page.dart';
import 'package:humab/screens/welcome/widgets/action_button.dart';
import 'package:humab/screens/welcome/widgets/voltar_button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  DateTime? selectedData;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DefinicoesProvider _definicoesProvider = Provider.of<DefinicoesProvider>(context);

    ScreenHelper.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      mockpuSize: const Size(411, 731),
    );

    return Scaffold(
      //key: _scaffoldState,
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 52.h, left: 0, right: 0, bottom: 25.h),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    const GeneroPage(),
                    const LocalAdministracaoPage(),
                    const LocalInjeccaoPage(),
                    const PeriodicidadePage(),
                    ProximaDataPage(
                      dataChangesCallback: (data) {
                        setState(() {
                          selectedData = data;
                        });
                      },
                      currentData: selectedData,
                    ),
                  ],
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => buildStepper(page: index)),
              ),
              SizedBox(height: 52.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: currentPage > 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                  children: [
                    if (currentPage > 0)
                      VoltarButton(
                        press: () {
                          setState(() {
                            currentPage--;
                            gotoPage(currentPage);
                          });
                        },
                      ),
                    ActionButton(
                      currentPage: currentPage,
                      pagesCount: 5,
                      press: (currentPage < 4)
                          ? gotoNextPage
                          : (selectedData != null)
                              ? () {
                                  Provider.of<InjecaoProvider>(context, listen: false).gerarProximaInjeccao(
                                    Injecao(
                                      data: selectedData!,
                                      local: _definicoesProvider.localInjeccao,
                                    ),
                                  );
                                  _definicoesProvider.welcome = false;
                                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                                }
                              : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void gotoPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void gotoNextPage() {
    setState(() {
      currentPage++;
      gotoPage(currentPage);
    });
  }

  AnimatedContainer buildStepper({int page = 0}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 10.h,
      width: currentPage == page ? 30.h : 10.h,
      decoration: BoxDecoration(
        color: currentPage >= page ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.white, width: 2.h),
      ),
    );
  }
}
