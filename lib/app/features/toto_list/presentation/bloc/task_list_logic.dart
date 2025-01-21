import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';

@injectable
class TaskListLogic {
  late IsarConfig isarConfig;
  TaskListLogic(this.isarConfig);

  StreamSubscription? taskSubscription;
  late final Stream<List<TaskModel>> taskStream;

  void init() {
    // Stream des tâches
    taskStream = isarConfig.instance.taskModels
        .where()
        .watch(fireImmediately: true)
        .asBroadcastStream();

    // Écoute des mises à jour
    taskSubscription = taskStream.listen((tasks) {
      log('Tâches mises à jour : ${tasks.map((e) => e.title).toList()}');
    });
  }

  void close() {
    if (taskSubscription != null) {
      taskSubscription!.cancel();
    }
  }
}
