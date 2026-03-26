// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Colombia Tetris';

  @override
  String get gameMode => 'Modo de juego';

  @override
  String departmentPlacement(String name) {
    return 'Ubica: $name';
  }

  @override
  String surface(String value) {
    return 'Superficie: $value km²';
  }

  @override
  String get lives => 'Vidas';

  @override
  String get score => 'Puntaje';

  @override
  String get gameOver => 'Juego terminado';

  @override
  String get victory => '¡Victoria!';

  @override
  String get next => 'Siguiente';
}
