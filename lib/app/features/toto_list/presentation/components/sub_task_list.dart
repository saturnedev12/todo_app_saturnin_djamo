import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/sub_task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/sub_task_item.dart';

class ListSubTask extends StatefulWidget {
  const ListSubTask({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<ListSubTask> createState() => _ListSubTaskState();
}

class _ListSubTaskState extends State<ListSubTask> {
  late final Isar _isar;
  late final Stream<List<SubTaskModel>> _subTasks;
  late final StreamSubscription
      _taskSubscription; // Pour fermer manuellement si nécessaire

  @override
  void initState() {
    super.initState();
    _isar = getIt<IsarConfig>().instance;
    _subTasks = _isar.subTaskModels
        .where()
        .idTaskEqualTo(widget.taskModel.id)
        .watch(fireImmediately: true)
        .asBroadcastStream();
    _taskSubscription = _subTasks.listen((tasks) {
      debugPrint('Tâches mises à jour : ${tasks.map((e) => e.title).toList()}');
    });
  }

  @override
  void dispose() {
    // Fermer le stream dans dispose
    _taskSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SubTaskModel>>(
      stream: _subTasks,
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
  // onPressed: () async {
  //         // Ajouter une nouvelle tâche
  //         final newTask = TaskModel()
  //           ..title = 'Nouvelle tâche'
  //           ..description = 'Description par défaut'
  //           ..isCompleted = false
  //           ..createdAt = DateTime.now();

  //         await _isar.writeTxn(() async {
  //           await _isar.taskModels.put(newTask);
  //         });
  //       },