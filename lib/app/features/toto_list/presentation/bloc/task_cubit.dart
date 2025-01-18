import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/repositories/task_repository.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final TaskRepository _taskRepository;

  TaskListCubit(this._taskRepository) : super(const TaskListState.initial());

  /// Charger toutes les tâches
  Future<void> fetchTasks() async {
    emit(const TaskListState.loading());
    try {
      final tasks = await _taskRepository.getAllTasks();
      emit(TaskListState.data(tasks));
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }

  /// Ajouter une tâche
  Future<void> addTask(TaskEntity task) async {
    emit(const TaskListState.loading());
    try {
      await _taskRepository.addTask(task);
      fetchTasks(); // Rafraîchir la liste des tâches
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }

  /// Supprimer une tâche
  Future<void> deleteTask(int id) async {
    emit(const TaskListState.loading());
    try {
      await _taskRepository.deleteTask(id);
      fetchTasks(); // Rafraîchir la liste des tâches
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }

  /// Mettre à jour une tâche
  Future<void> updateTask(TaskEntity task) async {
    emit(const TaskListState.loading());
    try {
      await _taskRepository.updateTask(task);
      fetchTasks(); // Rafraîchir la liste des tâches
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }
}
