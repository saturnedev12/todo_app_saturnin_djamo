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
import 'package:saturne_todo_app_djamo/app/core/config/theme_config.dart'
    as _i9;
import 'package:saturne_todo_app_djamo/app/core/utils/theme_handler.dart'
    as _i10;
import 'package:saturne_todo_app_djamo/app/features/home/presentation/bloc/theme_bloc.dart'
    as _i13;
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/repositories/task_repository_impl.dart'
    as _i7;
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/repositories/task_repository.dart'
    as _i6;
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/use_cases/task_use_case.dart'
    as _i8;
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_cubit.dart'
    as _i11;
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/sub_task_logic.dart'
    as _i4;
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart'
    as _i12;
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_logic.dart'
    as _i5;

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
    gh.factory<_i4.SubTaskLogic>(() => _i4.SubTaskLogic(gh<_i3.IsarConfig>()));
    gh.factory<_i5.TaskListLogic>(
        () => _i5.TaskListLogic(gh<_i3.IsarConfig>()));
    gh.singleton<_i6.TaskRepository>(
        () => _i7.TaskRepositoryImpl(gh<_i3.IsarConfig>()));
    gh.lazySingleton<_i8.TaskUseCase>(
        () => _i8.TaskUseCase(gh<_i6.TaskRepository>()));
    gh.singleton<_i9.ThemeConfig>(() => _i9.ThemeConfig());
    gh.lazySingleton<_i10.ThemeHandler>(() => _i10.ThemeHandler());
    gh.factory<_i11.CheckModeCubit>(
        () => _i11.CheckModeCubit(gh<_i3.IsarConfig>()));
    gh.factory<_i12.TaskListCubit>(
        () => _i12.TaskListCubit(gh<_i6.TaskRepository>()));
    gh.lazySingleton<_i13.ThemeBloc>(
        () => _i13.ThemeBloc(gh<_i10.ThemeHandler>()));
    return this;
  }
}
