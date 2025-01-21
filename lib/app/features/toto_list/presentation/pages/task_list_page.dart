// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
      backgroundColor: HexColor('#F0F5FA'),
      body: StreamBuilder<List<TaskModel>>(
        stream: taskListLogic.taskStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          taskListLogic.pagingController.refresh();
          // final tasks = snapshot.data ?? [];

          // if (tasks.isEmpty) {
          //   return const Center(
          //     child: Text('Aucune tâche trouvée.'),
          //   );
          // }

          return CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverGap(10),
              PagedSliverList<int, TaskModel>(
                pagingController: taskListLogic.pagingController,
                builderDelegate: PagedChildBuilderDelegate<TaskModel>(
                  itemBuilder: (context, task, index) => TaskItem(task: task),
                  noItemsFoundIndicatorBuilder: (context) => const Center(
                    child: Text('Aucune tâche trouvée.'),
                  ),
                  firstPageErrorIndicatorBuilder: (context) => const Center(
                    child: Text('Erreur lors du chargement des données.'),
                  ),
                  newPageErrorIndicatorBuilder: (context) => const Center(
                    child:
                        Text('Erreur lors du chargement de la page suivante.'),
                  ),
                  firstPageProgressIndicatorBuilder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                  newPageProgressIndicatorBuilder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.white,
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
