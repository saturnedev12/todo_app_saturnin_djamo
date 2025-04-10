import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/bloc/theme_bloc.dart';

class SelectThemeButton extends StatelessWidget {
  const SelectThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        // Détermine le nouveau thème à appliquer
        final currentTheme = state.themeType;

        return IconButton(
          onPressed: () {
            late ThemeType newThemeType;
            if (currentTheme == ThemeType.light) {
              newThemeType = ThemeType.dark;
            } else if (currentTheme == ThemeType.dark) {
              newThemeType = ThemeType.system;
            } else if (currentTheme == ThemeType.system) {
              newThemeType = ThemeType.light;
            }

            context.read<ThemeBloc>().add(ThemeEvent(newThemeType));
          },
          icon: Icon(
            (currentTheme == ThemeType.dark)
                ? Icons.wb_sunny
                : (currentTheme == ThemeType.light)
                    ? Icons.nights_stay
                    : CupertinoIcons.gear,
            color: (currentTheme == ThemeType.dark)
                ? Colors.yellow
                : Colors.blueGrey,
            size: 25,
          ),
        );
      },
    );
  }
}
