import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/bloc/theme_bloc.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/pages/home_page.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskListCubit>(
          create: (context) => getIt<TaskListCubit>(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => getIt<ThemeBloc>(),
        ),
        BlocProvider<CheckModeCubit>(
          create: (context) => getIt<CheckModeCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.themeData,
            darkTheme:
                (state.themeType == ThemeType.system) ? ThemeData.dark() : null,
            home: const HomePage(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
