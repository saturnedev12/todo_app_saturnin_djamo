import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';

@singleton
class IsarConfig {
  late final Isar _isar;

  /// Initialisation de la base de données Isar
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [TaskModelSchema],
      directory: dir.path,
    );
  }

  /// Fournit une instance de Isar
  Isar get instance => _isar;
}
