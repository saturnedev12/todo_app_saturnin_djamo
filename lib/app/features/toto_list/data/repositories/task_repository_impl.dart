import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';

import '../../domain/repositories/task_repository.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final Isar _isar;

  TaskRepositoryImpl(this._isar);

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    final tasks = await _isar.taskModels.where().findAll();
    return tasks.map((e) => e.toEntity()).toList();
  }

  @override
  Future<TaskEntity?> getTaskById(int id) async {
    final task = await _isar.taskModels.get(id);
    return task?.toEntity();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final taskModel = task.toModel();
    await _isar.writeTxn(() async {
      await _isar.taskModels.put(taskModel);
    });
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final taskModel = task.toModel();
    await _isar.writeTxn(() async {
      await _isar.taskModels.put(taskModel);
    });
  }

  @override
  Future<void> deleteTask(int id) async {
    await _isar.writeTxn(() async {
      await _isar.taskModels.delete(id);
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
    ..id = id
    ..title = title
    ..description = description
    ..isCompleted = isCompleted
    ..createdAt = createdAt;
}
