import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/sub_task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_logic.dart';

class AddSubTaskCompoent extends StatefulWidget {
  const AddSubTaskCompoent({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<AddSubTaskCompoent> createState() => _AddSubTaskCompoentState();
}

class _AddSubTaskCompoentState extends State<AddSubTaskCompoent> {
  final taskListLogic = getIt<TaskListLogic>();

  final FocusNode _focusNode = FocusNode();
  late TextEditingController textEditingController;
  double _keyboardHeight = 0.0;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _focusNode.addListener(
      () {
        setState(() {});
        if (!_focusNode.hasFocus) {
          //Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Vérifie la hauteur du clavier en temps réel
    double currentKeyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    if (currentKeyboardHeight == 0 && _keyboardHeight > 0) {
      // Le clavier vient de disparaître
      if (Navigator.of(context).canPop()) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      }

      // Future.delayed(Duration(seconds: 3), () {
      //   Navigator.of(context).pop();
      // });
    }

    _keyboardHeight = currentKeyboardHeight; //
    return CupertinoListTile(
      title: CupertinoTextField(
        focusNode: _focusNode,
        controller: textEditingController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        // autofocus: true,
        placeholder: 'Entrez une sous tâche',
        placeholderStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).primaryColor),
        prefix: _focusNode.hasFocus
            ? Icon(Icons.radio_button_unchecked)
            : Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
        decoration: BoxDecoration(border: Border.all(style: BorderStyle.none)),
        onEditingComplete: () async {
          log('DONE');
          if (textEditingController.text.isNotEmpty) {
            await taskListLogic.isarConfig.instance.writeTxn(() async {
              await taskListLogic.isarConfig.instance.subTaskModels
                  .put(SubTaskModel()
                    ..isCompleted = false
                    ..idTask = widget.taskModel.id
                    ..title = textEditingController.text
                    ..createdAt = DateTime.now());
            });
            textEditingController.clear();
          }
        },
      ),
    );
  }
}
