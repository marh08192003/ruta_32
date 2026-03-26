// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Colombia Tetris';

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
}
