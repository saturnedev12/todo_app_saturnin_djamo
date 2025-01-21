import 'package:flutter/material.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/pages/task_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Liste des tâches'),
          ),
          body: TaskListPage());
    });
  }
}
