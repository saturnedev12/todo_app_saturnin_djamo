import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';

import 'injectable_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
  await getIt<IsarConfig>().init(); // Initialisation de Isar
}
