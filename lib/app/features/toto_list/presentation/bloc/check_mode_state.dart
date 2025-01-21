import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';
part 'check_mode_state.freezed.dart';

@freezed
class CheckModeState with _$CheckModeState {
  static List<int> listTaskIndex = [];
  const factory CheckModeState.initial() = CHECK_INITIAL;
  const factory CheckModeState.loading() = CHECK_LOADING;
  const factory CheckModeState.data(
      List<int> listTaskIndex, bool? allSelected) = CHECK_TASK_LIST;
  const factory CheckModeState.error(String message) = CHECK_LIST_ERROR;
}
