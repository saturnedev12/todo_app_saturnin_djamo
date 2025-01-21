import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';

@singleton
class TaskListLogic {
  late IsarConfig isarConfig;
  late final Stream<List<TaskModel>> taskStream;
  late PagingController<int, TaskModel> pagingController;
  static const int _pageSize = 10;
  TaskListLogic(this.isarConfig);

  void init() {
    pagingController = PagingController(firstPageKey: 0);

    taskStream = isarConfig.instance.taskModels
        .where()
        .watch(fireImmediately: true)
        .asBroadcastStream();
    pagingController.addPageRequestListener(_fetchPage);
    pagingController.refresh();
  }

  /// Charger une page de données depuis Isar
  Future<void> _fetchPage(int pageKey) async {
    try {
      final tasks = await isarConfig.instance.taskModels
          .where()
          .offset(pageKey) // Point de départ
          .limit(_pageSize) // Nombre d'éléments à charger
          .findAll();

      final isLastPage = tasks.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(tasks);
      } else {
        final nextPageKey = pageKey + tasks.length;
        pagingController.appendPage(tasks, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void close() {
    pagingController.dispose();
  }
}
