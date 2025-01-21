import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/sub_task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';

@injectable
class SubTaskLogic {
  late IsarConfig isarConfig;
  SubTaskLogic(this.isarConfig);

  late final Stream<List<SubTaskModel>> subTasks;
  StreamSubscription?
      taskSubscription; // Pour fermer manuellement si nécessaire
  final FocusNode focusNode = FocusNode();
  late TextEditingController textEditingController;
  double keyboardHeight = 0.0;
  initList({required TaskModel taskModel}) {
    subTasks = isarConfig.instance.subTaskModels
        .where()
        .idTaskEqualTo(taskModel.id)
        .watch(fireImmediately: true)
        .asBroadcastStream();
    taskSubscription = subTasks.listen((tasks) {
      log('Tâches mises à jour : ${tasks.map((e) => e.title).toList()}');
    });
  }

  void initSingle({required TaskModel taskModel, required subTaskModel}) {
    textEditingController = TextEditingController(text: subTaskModel.title);
  }

  completed({required SubTaskModel subTaskModel}) {
    isarConfig.instance.writeTxn(() async {
      subTaskModel.isCompleted = !subTaskModel.isCompleted;
      await isarConfig.instance.subTaskModels.put(subTaskModel);
    });
  }

  delete({required SubTaskModel subTaskModel}) {}

  create({required SubTaskModel subTaskModel}) async {
    if (textEditingController.text.isNotEmpty) {
      await isarConfig.instance.writeTxn(() async {
        await isarConfig.instance.subTaskModels.put(
          SubTaskModel()
            ..id = subTaskModel.id
            ..idTask = subTaskModel.idTask
            ..isCompleted = subTaskModel.isCompleted
            ..title = textEditingController.text
            ..createdAt = subTaskModel.createdAt,
        );
      });
    }
  }

  updatte({required SubTaskModel subTaskModel}) async {
    if (textEditingController.text.isNotEmpty) {
      await isarConfig.instance.writeTxn(() async {
        await isarConfig.instance.subTaskModels.put(
          SubTaskModel()
            ..id = subTaskModel.id
            ..idTask = subTaskModel.idTask
            ..isCompleted = subTaskModel.isCompleted
            ..title = textEditingController.text
            ..createdAt = subTaskModel.createdAt,
        );
      });
    }
  }

  void close() {
    // Fermer le stream dans dispose
    if (taskSubscription != null) {
      taskSubscription!.cancel();
    }
  }
}
