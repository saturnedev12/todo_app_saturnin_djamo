import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_state.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_logic.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/priority_color_selector.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/screens/task_detail_screen.dart';

class TaskItem extends StatelessWidget {
  TaskItem({super.key, required this.task});
  final TaskModel task;
  final taskListLogic = getIt<TaskListLogic>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 6),
      decoration: BoxDecoration(
        color: (task.color == PriorityColor.important.name)
            ? Colors.red
            : (task.color == PriorityColor.warning.name)
                ? Colors.orange
                : theme.cardColor, // Utilise la couleur de carte du thème
        borderRadius: BorderRadius.circular(20),
      ),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.error, // Couleur rouge pour supprimer
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                FontAwesomeIcons.trashCan,
                color: Colors.white,
              ),
              const Gap(10),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary, // Couleur secondaire
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onDismissed: (direction) {
          if (direction.name == DismissDirection.endToStart.name) {
            context.read<TaskListCubit>().deleteTask(task.id);
          }
        },
        key: Key(task.id.toString()),
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Supprimer la tâche'),
                content: const Text(
                    'Êtes-vous sûr de vouloir supprimer cette tâche ?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Supprimer'),
                  ),
                ],
              );
            },
          );
        },
        child: ListTile(
          horizontalTitleGap: 0,
          minLeadingWidth: 0,
          leading: IconButton(
            onPressed: () async {
              // Inverser l'état de complétion
              await taskListLogic.isarConfig.instance.writeTxn(() async {
                task.isCompleted = !task.isCompleted;
                await taskListLogic.isarConfig.instance.taskModels.put(task);
              });
            },
            icon: Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: theme.colorScheme.primary, // Utilise la couleur primaire
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            task.title,
            style: theme.textTheme.titleMedium!.copyWith(
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough
                  : null, // Ligne barrée si terminé
            ),
          ),
          // subtitle:
          //     task.description != null ? Text(task.description ?? '') : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => TaskDetailScreen(taskModel: task),
              ),
            );
          },
          trailing: BlocBuilder<CheckModeCubit, CheckModeState>(
            builder: (context, state) {
              return (state is CHECK_TASK_LIST)
                  ? Checkbox(
                      value: state.listTaskIndex.contains(task.id),
                      onChanged: (bool? value) {
                        if (state.listTaskIndex.contains(task.id)) {
                          log('deleted');
                          context.read<CheckModeCubit>().withdrwCheck(task.id);
                        } else {
                          context.read<CheckModeCubit>().addCheck(task.id);
                        }
                      })
                  : SizedBox(
                      width: 1,
                    );
            },
          ),
        ),
      ),
    );
  }
}
