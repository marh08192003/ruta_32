// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'RUTA 32';

  @override
  String get gameMode => 'Game mode';

  @override
  String departmentPlacement(String name) {
    return 'Place: $name';
  }

  @override
  String surface(String value) {
    return 'Surface: $value km²';
  }

  @override
  String get lives => 'Lives';

  @override
  String get score => 'Score';

  @override
  String get gameOver => 'Game over';

  @override
  String get victory => 'Victory!';

  @override
  String get play => 'Play';

  @override
  String get info => 'INFO';

  @override
  String get tutorialTitle => 'Ruta 32 - Tutorial';

  @override
  String get howToPlayText =>
      '1. Pieces fall from above.\n2. Drag them horizontally.\n3. Align them with their map position before they touch the ground.\n4. If you miss, you lose a life.';

  @override
  String get ok => 'OK';

  @override
  String get language => 'Language';

  @override
  String get spanish => 'ES';

  @override
  String get english => 'EN';
}
