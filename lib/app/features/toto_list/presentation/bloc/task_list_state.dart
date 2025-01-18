import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';
part 'task_list_state.freezed.dart';

@freezed
class TaskListState with _$TaskListState {
  const factory TaskListState.initial() = TASK_LIST_INITIAL;
  const factory TaskListState.loading() = TASK_LIST_LOADING;
  const factory TaskListState.data(List<TaskEntity> listTask) = TASK_LIST;
  const factory TaskListState.error(String message) = TASK_LIST_ERROR;
}
