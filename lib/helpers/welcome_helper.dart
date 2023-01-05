class WelcomeHelper {
  int genero = 0;
  int localAdministracao = 0;
  int localInjeccao = 0;
  int periodicidade = 0;
  DateTime? data = DateTime.now();

  static final WelcomeHelper instance = WelcomeHelper._init();
  WelcomeHelper._init();
}
