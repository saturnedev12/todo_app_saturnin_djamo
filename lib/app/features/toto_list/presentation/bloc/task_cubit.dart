import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_state.dart';

import '../../domain/repositories/task_repository.dart';

@injectable
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
      // Extraire uniquement le message de l'exception
      emit(TaskListState.error(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Ajouter une tâche
  Future<void> addTask(TaskEntity task) async {
    log('ADD Task');
    emit(const TaskListState.loading());
    try {
      await _taskRepository.addTask(task);
      await fetchTasks(); // Rafraîchir la liste des tâches
    } catch (e) {
      inspect(e);
      emit(TaskListState.error(e.toString()));
    }
  }

  /// Supprimer une tâche
  Future<void> deleteTask(int id) async {
    emit(const TaskListState.loading());
    try {
      await _taskRepository.deleteTask(id);
      await fetchTasks(); // Rafraîchir la liste des tâches
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }

  /// Supprimer plusieurs tâches
  Future<void> deleteMultipleTasks(List<int> ids) async {
    emit(const TaskListState.loading());
    try {
      await _taskRepository.deleteTasks(ids);
      await fetchTasks();
    } catch (e) {
      emit(TaskListState.error(e.toString())); // Gestion des erreurs
    }
  }

  /// Supprimer plusieurs tâches
  Future<void> deleteAllTasks() async {
    emit(const TaskListState.loading());
    try {
      await _taskRepository.deleteAllTasks();
      await fetchTasks();
    } catch (e) {
      emit(TaskListState.error(e.toString())); // Gestion des erreurs
    }
  }

  /// Mettre à jour une tâche
  Future<void> updateTask(TaskEntity task) async {
    emit(const TaskListState.loading());
    try {
      await _taskRepository.updateTask(task);
      await fetchTasks(); // Rafraîchir la liste des tâches
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }
}
