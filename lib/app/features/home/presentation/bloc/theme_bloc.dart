import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:saturne_todo_app_djamo/app/core/utils/theme_handler.dart';

enum ThemeType { system, light, dark }

class ThemeState {
  final ThemeType themeType;
  final ThemeData themeData;

  ThemeState(this.themeType, this.themeData);
}

class ThemeEvent {
  final ThemeType themeType;

  ThemeEvent(this.themeType);
}

@lazySingleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeHandler themeHandler;

  ThemeBloc(this.themeHandler) : super(_getInitialTheme(themeHandler)) {
    on<ThemeEvent>((event, emit) async {
      // Sauvegarder le thème sélectionné
      await themeHandler.saveTheme(event.themeType);

      // Récupérer et émettre le nouveau thème
      emit(ThemeState(event.themeType, _getThemeData(event.themeType)));
    });
  }

  static ThemeState _getInitialTheme(ThemeHandler themeHandler) {
    // Charger le thème sauvegardé ou utiliser le thème par défaut
    return ThemeState(
      ThemeType.system,
      _getThemeData(ThemeType.system),
    );
  }

  static ThemeData _getThemeData(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        return _lightTheme();
      case ThemeType.dark:
        return _darkTheme();
      default:
        return WidgetsBinding.instance.window.platformBrightness ==
                Brightness.dark
            ? _darkTheme()
            : _lightTheme();
    }
  }

  static ThemeData _lightTheme() {
    return ThemeData(
      primaryColor: Colors.indigo.shade900,
      scaffoldBackgroundColor: const Color.fromARGB(
          255, 234, 236, 250), // Couleur douce pour le fond
      textTheme: GoogleFonts.latoTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(255, 234, 236, 250),
        titleTextStyle: GoogleFonts.lato(fontSize: 20, color: Colors.black),
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.white,
        textColor: Colors.black,
      ),
      cardColor: Colors.white, // Couleur des cartes (tâches)
      colorScheme: ColorScheme.light(
        primary: Colors.indigo.shade900,
        secondary: Colors.blueAccent,
        error: Colors.redAccent,
        surface: Colors.white, // Fond des tâches
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        deleteIconColor: Colors.indigo[900],
        disabledColor: Colors.grey.shade300,
        selectedColor: Colors.indigo[100],
        secondarySelectedColor: Colors.indigo[100],
        labelStyle: GoogleFonts.lato(
          fontSize: 12, // Taille du texte
          color: Colors.indigo[900],
        ),
        secondaryLabelStyle: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.indigo[700],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(16), // Coins bien arrondis
        ),
      ),
    );
  }

  static ThemeData _darkTheme() {
    return ThemeData(
      primaryColor: Colors.indigo[900],
      scaffoldBackgroundColor:
          const Color(0xFF121212), // Couleur sombre pour le fond
      textTheme: GoogleFonts.latoTextTheme(
        ThemeData.dark().textTheme,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF121212),
        titleTextStyle: GoogleFonts.lato(fontSize: 20, color: Colors.white),
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: Color(0xFF1E1E1E),
        textColor: Colors.white,
      ),
      cardColor: const Color(0xFF1E1E1E), // Couleur des cartes (tâches)
      iconTheme: const IconThemeData(
        color: Colors.white, // Icônes blanches par défaut
      ),
      colorScheme: ColorScheme.dark(
        primary: Colors.indigo.shade900,
        secondary: Colors.blueAccent,
        error: Colors.redAccent,
        surface: const Color(0xFF1E1E1E), // Fond des tâches
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        deleteIconColor: Colors.white,
        disabledColor: Colors.grey.shade700,
        selectedColor: Colors.indigo[300],
        secondarySelectedColor: Colors.indigo[300],
        labelStyle: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.white,
        ),
        secondaryLabelStyle: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.white70,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
