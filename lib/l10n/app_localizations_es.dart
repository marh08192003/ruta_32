// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'RUTA 32';

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
  String get play => 'Jugar';

  @override
  String get info => 'INFO';

  @override
  String get tutorialTitle => 'Ruta 32 - Tutorial';

  @override
  String get howToPlayText =>
      '1. Las piezas caen desde arriba.\n2. Arrástralas horizontalmente.\n3. Alínealas con su posición en el mapa antes de que toquen el suelo.\n4. Si fallas, pierdes una vida.';

  @override
  String get ok => 'OK';

  @override
  String get language => 'Idioma';

  @override
  String get spanish => 'ES';

  @override
  String get english => 'EN';

  @override
  String get population => 'Población';

  @override
  String get region => 'Región';

  @override
  String get aboutDepartment => 'Sobre el departamento';

  @override
  String get loadingDescription => 'Cargando descripción...';

  @override
  String capital(String name) {
    return 'Capital: $name';
  }

  @override
  String get heritageTitle => 'Patrimonio Inmaterial';

  @override
  String get gastronomyTitle => 'Gastronomía Típica';

  @override
  String get culturalHeritage => 'Patrimonio Cultural';

  @override
  String departmentsByRegion(String regionName) {
    return 'Departamentos: $regionName';
  }

  @override
  String get regionsOfColombia => 'Regiones de Colombia';

  @override
  String get explore => 'EXPLORAR RUTAS';

  @override
  String get mainMenu => 'MENÚ PRINCIPAL';

  @override
  String get aboutColombia =>
      'Ruta 32 es un tributo a los 32 departamentos de Colombia. Aprende su ubicación y tamaño mientras juegas.';

  @override
  String get extraLife => 'VIDA EXTRA (AD)';

  @override
  String get noInternet => 'Sin conexión a internet';

  @override
  String get sourceCredit => 'Datos proporcionados por:';
}
