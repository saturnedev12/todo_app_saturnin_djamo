// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_logic.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/add_task_compoent.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/task_item.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final taskListLogic = getIt<TaskListLogic>();

  @override
  void initState() {
    super.initState();
    taskListLogic.init();
  }

  @override
  void dispose() {
    taskListLogic.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<TaskModel>>(
        stream: taskListLogic.taskStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      FontAwesomeIcons.boxArchive,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Aucun éléments',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const Gap(10),
                  Text(
                    "Vous n'avez aucune tâche en cours, veuillez ajouter de nouvelles tâches.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskItem(task: task);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskCompoent(),
          ).then(
            (value) {
              if (value is TaskEntity) {
                context.read<TaskListCubit>().addTask(value);
              }
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
