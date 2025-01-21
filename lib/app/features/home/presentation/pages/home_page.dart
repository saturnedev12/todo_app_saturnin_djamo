import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/bloc/theme_bloc.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/components/select_button.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/components/select_handler.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/components/task_progress_bar.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_state.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/pages/task_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
              title: const Text('Liste des tâches'),
              actions: [
                SelectButton(),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    // Détermine le nouveau thème à appliquer
                    final isDarkMode = state.themeType == ThemeType.dark;
                    final newThemeType =
                        isDarkMode ? ThemeType.light : ThemeType.dark;

                    return IconButton(
                      onPressed: () {
                        // Ajoute l'événement pour changer le thème
                        context.read<ThemeBloc>().add(ThemeEvent(newThemeType));
                      },
                      icon: Icon(
                        isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
                        color: isDarkMode ? Colors.yellow : Colors.blueGrey,
                        size: 25,
                      ),
                    );
                  },
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: BlocBuilder<CheckModeCubit, CheckModeState>(
                  builder: (context, state) {
                    return (state is CHECK_TASK_LIST)
                        ? SelectHandlerHome(numTask: state.listTaskIndex.length)
                        : TaskProgressBar();
                  },
                ),
              )),
          body: TaskListPage(),
        );
      },
    );
  }
}
