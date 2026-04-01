# Ruta 32 - Descubre Colombia 🇨🇴

**Ruta 32** es una aplicación móvil educativa e interactiva desarrollada con **Flutter**. El objetivo es enseñar la geografía y cultura de los 32 departamentos de Colombia a través de un juego de precisión y una guía turística detallada que consume datos en tiempo real.

## 🚀 Características principales

- **Mini-juego Geográfico:** Ubica los departamentos en el mapa mientras caen, gestionando vidas y puntajes.
- **Exploración por Regiones:** Consulta detalles de cada departamento (Población, Superficie, Capital).
- **Patrimonio y Gastronomía:** Visualización de datos culturales con scroll horizontal y consumo de API.
- **Soporte Multi-idioma:** Localización completa en Español e Inglés (i18n) mediante archivos `.arb`.
- **Arquitectura Robusta:** Gestión de estado escalable y sistema de caché in-memory.

## 🛠️ Stack Tecnológico

- **Framework:** [Flutter](https://flutter.dev)
- **Gestión de Estado:** [Riverpod](https://riverpod.dev) (StateNotifier & Providers)
- **Navegación:** Navigator 1.0 / 2.0
- **Consumo de API:** [Http](https://pub.dev/packages/http) para peticiones REST.
- **Persistencia/Caché:** Lógica personalizada con providers para optimizar peticiones externas.
- **Localización:** `flutter_localizations` (Generación de código l10n).

## 📡 Fuentes de Datos

La aplicación consume datos en tiempo real de la **[API Colombia](https://api-colombia.com/)**, un proyecto open-source que provee información detallada sobre la biodiversidad, geografía y cultura del país. Se utilizan específicamente los endpoints de:

- **Departamentos:** Detalles generales, población y superficie.
- **Patrimonio Inmaterial:** Información sobre tradiciones y cultura local.
- **Gastronomía:** Platos típicos por región.

## 📦 Instalación y Uso

1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/marh08192003/ruta_32](https://github.com/marh08192003/ruta_32)
   ```
2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```
3. **Generar archivos de localización (L10n):**
   Si has modificado las traducciones, ejecuta:
   ```bash
   flutter gen-l10n
   ```
4. **Ejecutar el proyecto:**
   ```bash
   flutter run
   ```

## 🧩 Decisiones de Diseño Técnico

- **Optimización de Datos:** Se implementó un `DepartmentCacheNotifier` para evitar llamadas redundantes a la API al navegar entre las pantallas de detalle de los departamentos.
- **Interfaz Fluida:** Uso de `SingleChildScrollView` con scroll horizontal para mejorar la visualización de la información cultural sin saturar la pantalla verticalmente.
- **Game Loop:** El estado del juego se centraliza en un `StateNotifier`, lo que permite una separación clara entre la lógica de colisiones/puntos y la interfaz de usuario.

---

Desarrollado por [Miguel Rivera/Marh0819]
