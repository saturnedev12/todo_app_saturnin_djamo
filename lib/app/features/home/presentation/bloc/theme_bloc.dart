import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saturne_todo_app_djamo/app/core/config/theme_config.dart';
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
        return ThemeConfig.lightTheme();
      case ThemeType.dark:
        return ThemeConfig.darkTheme();
      default:
        return WidgetsBinding.instance.window.platformBrightness ==
                Brightness.dark
            ? ThemeConfig.darkTheme()
            : ThemeConfig.lightTheme();
    }
  }
}
