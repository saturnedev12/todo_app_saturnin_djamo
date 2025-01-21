import 'package:injectable/injectable.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';
import 'package:saturne_todo_app_djamo/app/features/home/domain/models/theme_model.dart';
import 'package:saturne_todo_app_djamo/app/features/home/presentation/bloc/theme_bloc.dart';

@lazySingleton
class ThemeHandler {
  final isarConfig = getIt<IsarConfig>();

  saveTheme(ThemeType themeType) async {
    final themeModel = ThemeModel()..themeType = themeType.toString();
    await isarConfig.instance
        .writeTxn(() async => isarConfig.instance.themeModels.put(themeModel));
  }

  Future<ThemeType> getSavedTheme() async {
    final themeModel = await isarConfig.instance.themeModels.get(0);
    if (themeModel == null) return ThemeType.system;
    return ThemeType.values.firstWhere(
      (e) => e.toString() == themeModel.themeType,
      orElse: () => ThemeType.system,
    );
  }
}
