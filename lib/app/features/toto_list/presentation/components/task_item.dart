import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_logic.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/screens/task_detail_screen.dart';

class TaskItem extends StatelessWidget {
  TaskItem({super.key, required this.task});
  final TaskModel task;
  final taskListLogic = getIt<TaskListLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          //margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                FontAwesomeIcons.trashCan,
                color: Colors.white,
              ),
              Gap(10),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        key: Key(task.id.toString()),
        onDismissed: (direction) {
          if (direction.name == DismissDirection.endToStart.name) {
            context.read<TaskListCubit>().deleteTask(task.id);
          }
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
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            //maxLines: 1,
            task.title,
          ),
          titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null),
          subtitle:
              (task.description != null) ? Text(task.description ?? '') : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          // trailing: SizedBox(
          //   width: 90,
          //   child: Center(
          //     child: CustomChip(
          //       label: 'important',
          //     ),
          //   ),
          // ),
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => TaskDetailScreen(taskModel: task),
              ),
            );
          },
        ),
      ),
    );
  }
}
