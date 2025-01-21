import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:saturne_todo_app_djamo/app/core/config/isar_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';

class TaskProgressBar extends StatelessWidget {
  TaskProgressBar({super.key});
  final isarConfig = getIt<IsarConfig>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TaskModel>>(
      stream: isarConfig.instance.taskModels
          .where()
          .watch(fireImmediately: true)
          .asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Erreur : ${snapshot.error}'),
          );
        }

        final tasks = snapshot.data ?? [];
        final totalTasks = tasks.length;
        final completedTasks = tasks.where((task) => task.isCompleted).length;

        final progress = totalTasks == 0
            ? 0.0
            : (completedTasks /
                totalTasks); // Ratio pour la barre de progression

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SimpleAnimationProgressBar(
                ratio: progress,
                width: MediaQuery.of(context).size.width * 0.8,
                height: 10,
                direction: Axis.horizontal,
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregrondColor: Theme.of(context).colorScheme.primary,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '$completedTasks tâches terminées sur $totalTasks',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
