import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_state.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart';

@injectable
class CheckModeCubit extends Cubit<CheckModeState> {
  IsarConfig isarConfig;
  CheckModeCubit(this.isarConfig) : super(CheckModeState.initial());

  statedCheck() {
    CheckModeState.listTaskIndex.clear();
    emit(CheckModeState.data([], false));
  }

  initialization() {
    CheckModeState.listTaskIndex.clear();
    emit(CheckModeState.initial());
  }

  endCheck() {
    CheckModeState.listTaskIndex.clear();
    emit(CheckModeState.initial());
  }

  addCheck(int index) {
    CheckModeState.listTaskIndex.add(index);
    emit(CheckModeState.data(CheckModeState.listTaskIndex, false));
  }

  withdrwCheck(int index) async {
    await Future.sync(
      () {
        CheckModeState.listTaskIndex.removeWhere(
          (element) => element == index,
        );
      },
    );

    emit(CheckModeState.data(CheckModeState.listTaskIndex, null));
  }

  selectAll() {
    isarConfig.instance.taskModels.where().idProperty().findAll().then(
      (value) {
        CheckModeState.listTaskIndex.clear();
        CheckModeState.listTaskIndex.addAll(value);
        emit(CheckModeState.data(CheckModeState.listTaskIndex, true));
      },
    );
  }

  deSelectAll() {
    CheckModeState.listTaskIndex.clear();
    emit(CheckModeState.data(CheckModeState.listTaskIndex, false));
  }

  removeCheck(BuildContext context) {
    context
        .read<TaskListCubit>()
        .deleteMultipleTasks(CheckModeState.listTaskIndex);
  }
}
