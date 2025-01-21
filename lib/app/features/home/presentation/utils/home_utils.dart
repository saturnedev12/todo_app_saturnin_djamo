import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/bloc/theme_bloc.dart';

void showThemeSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemeType.values.map((themeType) {
          return ListTile(
            title: Text(
              themeType.toString().split('.').last.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              // Émettre l'événement de changement de thème
              context.read<ThemeBloc>().add(ThemeEvent(themeType));
              Navigator.pop(context);
            },
          );
        }).toList(),
      );
    },
  );
}
