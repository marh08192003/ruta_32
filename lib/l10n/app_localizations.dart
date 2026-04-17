import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'RUTA 32'**
  String get appTitle;

  /// No description provided for @gameMode.
  ///
  /// In es, this message translates to:
  /// **'Modo de juego'**
  String get gameMode;

  /// No description provided for @departmentPlacement.
  ///
  /// In es, this message translates to:
  /// **'Ubica: {name}'**
  String departmentPlacement(String name);

  /// No description provided for @surface.
  ///
  /// In es, this message translates to:
  /// **'Superficie: {value} km²'**
  String surface(String value);

  /// No description provided for @lives.
  ///
  /// In es, this message translates to:
  /// **'Vidas'**
  String get lives;

  /// No description provided for @score.
  ///
  /// In es, this message translates to:
  /// **'Puntaje'**
  String get score;

  /// No description provided for @gameOver.
  ///
  /// In es, this message translates to:
  /// **'Juego terminado'**
  String get gameOver;

  /// No description provided for @victory.
  ///
  /// In es, this message translates to:
  /// **'¡Victoria!'**
  String get victory;

  /// No description provided for @play.
  ///
  /// In es, this message translates to:
  /// **'Jugar'**
  String get play;

  /// No description provided for @info.
  ///
  /// In es, this message translates to:
  /// **'INFO'**
  String get info;

  /// No description provided for @tutorialTitle.
  ///
  /// In es, this message translates to:
  /// **'Ruta 32 - Tutorial'**
  String get tutorialTitle;

  /// No description provided for @howToPlayText.
  ///
  /// In es, this message translates to:
  /// **'1. Las piezas caen desde arriba.\n2. Arrástralas horizontalmente.\n3. Alínealas con su posición en el mapa antes de que toquen el suelo.\n4. Si fallas, pierdes una vida.'**
  String get howToPlayText;

  /// No description provided for @ok.
  ///
  /// In es, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @language.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @spanish.
  ///
  /// In es, this message translates to:
  /// **'ES'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In es, this message translates to:
  /// **'EN'**
  String get english;

  /// No description provided for @population.
  ///
  /// In es, this message translates to:
  /// **'Población'**
  String get population;

  /// No description provided for @region.
  ///
  /// In es, this message translates to:
  /// **'Región'**
  String get region;

  /// No description provided for @aboutDepartment.
  ///
  /// In es, this message translates to:
  /// **'Sobre el departamento'**
  String get aboutDepartment;

  /// No description provided for @loadingDescription.
  ///
  /// In es, this message translates to:
  /// **'Cargando descripción...'**
  String get loadingDescription;

  /// No description provided for @capital.
  ///
  /// In es, this message translates to:
  /// **'Capital: {name}'**
  String capital(String name);

  /// No description provided for @heritageTitle.
  ///
  /// In es, this message translates to:
  /// **'Patrimonio Inmaterial'**
  String get heritageTitle;

  /// No description provided for @gastronomyTitle.
  ///
  /// In es, this message translates to:
  /// **'Gastronomía Típica'**
  String get gastronomyTitle;

  /// No description provided for @culturalHeritage.
  ///
  /// In es, this message translates to:
  /// **'Patrimonio Cultural'**
  String get culturalHeritage;

  /// No description provided for @departmentsByRegion.
  ///
  /// In es, this message translates to:
  /// **'Departamentos: {regionName}'**
  String departmentsByRegion(String regionName);

  /// No description provided for @regionsOfColombia.
  ///
  /// In es, this message translates to:
  /// **'Regiones de Colombia'**
  String get regionsOfColombia;

  /// No description provided for @explore.
  ///
  /// In es, this message translates to:
  /// **'EXPLORAR RUTAS'**
  String get explore;

  /// No description provided for @mainMenu.
  ///
  /// In es, this message translates to:
  /// **'MENÚ PRINCIPAL'**
  String get mainMenu;

  /// No description provided for @aboutColombia.
  ///
  /// In es, this message translates to:
  /// **'Ruta 32 es un tributo a los 32 departamentos de Colombia. Aprende su ubicación y tamaño mientras juegas.'**
  String get aboutColombia;

  /// No description provided for @extraLife.
  ///
  /// In es, this message translates to:
  /// **'VIDA EXTRA (AD)'**
  String get extraLife;

  /// No description provided for @noInternet.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión a internet'**
  String get noInternet;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
