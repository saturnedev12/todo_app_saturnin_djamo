import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks();
  Future<TaskEntity?> getTaskById(int id);
  Future<void> addTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(int id);
}
