import 'package:flutter/material.dart';
import 'package:saturne_todo_app_djamo/app/app.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/core/services/reminder_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await ReminderService.init();
  await configureDependencies();
  runApp(const MyApp());
}
