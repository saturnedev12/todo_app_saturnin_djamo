import 'package:injectable/injectable.dart';

import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

@lazySingleton
class TaskUseCase {
  final TaskRepository _repository;

  TaskUseCase(this._repository);

  /// Ajouter une tâche
  Future<void> addTask(TaskEntity task) async {
    await _repository.addTask(task);
  }

  /// Supprimer une tâche
  Future<void> deleteTask(int id) async {
    await _repository.deleteTask(id);
  }

  /// Récupérer toutes les tâches
  Future<List<TaskEntity>> getAllTasks() async {
    return await _repository.getAllTasks();
  }

  /// Récupérer une tâche par ID
  Future<TaskEntity?> getTaskById(int id) async {
    return await _repository.getTaskById(id);
  }

  /// Mettre à jour une tâche
  Future<void> updateTask(TaskEntity task) async {
    await _repository.updateTask(task);
  }
}
