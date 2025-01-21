import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';

import '../../domain/repositories/task_repository.dart';

@Singleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final IsarConfig _isarConfig;

  TaskRepositoryImpl(this._isarConfig);

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    final tasks = await _isarConfig.instance.taskModels.where().findAll();
    return tasks.map((e) => e.toEntity()).toList();
  }

  @override
  Future<TaskEntity?> getTaskById(int id) async {
    final task = await _isarConfig.instance.taskModels.get(id);
    return task?.toEntity();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final taskModel = task.toModel();
    await _isarConfig.instance.writeTxn(() async {
      await _isarConfig.instance.taskModels.put(taskModel);
    });
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final taskModel = task.toModel();
    await _isarConfig.instance.writeTxn(() async {
      await _isarConfig.instance.taskModels.put(taskModel);
    });
  }

  @override
  Future<void> deleteTask(int id) async {
    await _isarConfig.instance.writeTxn(() async {
      await _isarConfig.instance.taskModels.delete(id);
    });
  }
}

extension TaskModelMapper on TaskModel {
  TaskEntity toEntity() => TaskEntity(
        id: id,
        title: title,
        description: description,
        isCompleted: isCompleted,
        createdAt: createdAt,
      );
}

extension TaskEntityMapper on TaskEntity {
  TaskModel toModel() => TaskModel()
    ..id = id ?? Isar.autoIncrement
    ..title = title
    ..description = description
    ..isCompleted = isCompleted
    ..createdAt = createdAt;
}
