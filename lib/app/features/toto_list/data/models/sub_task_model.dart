import 'package:isar/isar.dart';

part 'sub_task_model.g.dart';

@collection
class SubTaskModel {
  Id id = Isar.autoIncrement;
  @Index(unique: false)
  late int idTask;
  late String title;
  late bool isCompleted;
  DateTime createdAt = DateTime.now();
}
