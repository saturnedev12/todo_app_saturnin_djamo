// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart' as _i3;
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/repositories/task_repository_impl.dart'
    as _i6;
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/repositories/task_repository.dart'
    as _i5;
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/use_cases/task_use_case.dart'
    as _i7;
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart'
    as _i8;
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_logic.dart'
    as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.IsarConfig>(() => _i3.IsarConfig());
    gh.singleton<_i4.TaskListLogic>(
        () => _i4.TaskListLogic(gh<_i3.IsarConfig>()));
    gh.singleton<_i5.TaskRepository>(
        () => _i6.TaskRepositoryImpl(gh<_i3.IsarConfig>()));
    gh.lazySingleton<_i7.TaskUseCase>(
        () => _i7.TaskUseCase(gh<_i5.TaskRepository>()));
    gh.factory<_i8.TaskListCubit>(
        () => _i8.TaskListCubit(gh<_i5.TaskRepository>()));
    return this;
  }
}
