import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_entity.freezed.dart';
part 'task_entity.g.dart';

@freezed
class TaskEntity with _$TaskEntity {
  /// Constructeur principal avec les propriétés nécessaires
  factory TaskEntity({
    required int id, // Identifiant unique
    required String title, // Titre de la tâche
    String? description, // Description optionnelle
    required bool isCompleted, // Statut de complétion
    required DateTime createdAt, // Date de création
  }) = _TaskEntity;

  /// Constructeur pour la sérialisation JSON
  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);
}
