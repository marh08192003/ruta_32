import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final localeProvider = StateProvider<Locale>((ref) {
  // Idioma por defecto
  return const Locale('es');
});