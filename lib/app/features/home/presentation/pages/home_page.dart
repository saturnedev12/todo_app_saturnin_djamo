import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/core/utils/theme_handler.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/bloc/theme_bloc.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/components/select_button.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/components/select_handler.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/components/select_theme_button.dart';
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
  final themeHandler = getIt<ThemeHandler>();
  @override
  void initState() {
    () {
      themeHandler.getSavedTheme().then(
        (value) {
          context.read<ThemeBloc>().add(ThemeEvent(value));
        },
      );
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
              title: const Text('Liste des tâches'),
              actions: [
                SelectButton(),
                SelectThemeButton(),
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
