import 'package:isar/isar.dart';

part 'task_model.g.dart'; // Généré avec isar_codegen

@Collection()
class TaskModel {
  Id id = Isar.autoIncrement; // ID auto-incrémenté
  late String title;
  String? description;
  late bool isCompleted;
  String? priority;
  DateTime createdAt = DateTime.now();
}
