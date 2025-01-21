import 'package:flutter/material.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/sub_task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/sub_task_logic.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/sub_task_item.dart';

class ListSubTask extends StatefulWidget {
  const ListSubTask({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<ListSubTask> createState() => _ListSubTaskState();
}

class _ListSubTaskState extends State<ListSubTask> {
  final subTaskLogic = getIt<SubTaskLogic>();

  @override
  void initState() {
    super.initState();
    subTaskLogic.initList(taskModel: widget.taskModel);
  }

  @override
  void dispose() {
    // Fermer le stream dans dispose
    subTaskLogic.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SubTaskModel>>(
      stream: subTaskLogic.subTasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
              child: const Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return SliverToBoxAdapter(
              child: Center(child: Text('Erreur : ${snapshot.error}')));
        }

        final tasks = snapshot.data ?? [];

        if (tasks.isEmpty) {
          return SliverToBoxAdapter();
        }

        return SliverList.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return SubTaskItem(subTaskModel: task, taskModel: widget.taskModel);
          },
        );
      },
    );
  }
}
