import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/priority_color_selector.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/reminder_picker.dart';

bool isPopupClosingManually = true;

class AddTaskCompoent extends StatefulWidget {
  const AddTaskCompoent({super.key});

  @override
  State<AddTaskCompoent> createState() => _AddTaskCompoentState();
}

class _AddTaskCompoentState extends State<AddTaskCompoent> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController textEditingController;
  double _keyboardHeight = 0.0;
  PriorityColor? currentColor = PriorityColor.none;
  DateTime? reminderDateTime;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _focusNode.addListener(
      () {
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
    if (currentKeyboardHeight == 0 &&
        _keyboardHeight > 0 &&
        isPopupClosingManually) {
      // Le clavier vient de disparaître
      if (Navigator.of(context).canPop()) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      }
    }

    _keyboardHeight = currentKeyboardHeight; //
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(10),
          CupertinoListTile(
            title: CupertinoTextField(
              focusNode: _focusNode,
              controller: textEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              autofocus: true,
              placeholder: 'Entrez une tâche',
              style: TextStyle(
                  color: Theme.of(context).listTileTheme.textColor,
                  fontSize: 16),
              decoration:
                  BoxDecoration(border: Border.all(style: BorderStyle.none)),
              onEditingComplete: () {
                log('DONE');
                if (textEditingController.text.isNotEmpty) {
                  // if (reminderDateTime != null) {
                  //   await ReminderService.scheduleReminder(
                  //     id: 1,
                  //     title: 'Tâche à faire',
                  //     body: textEditingController.text,
                  //     dateTime: reminderDateTime!,
                  //   );
                  // }
                  Navigator.pop(
                      context,
                      TaskEntity(
                          title: textEditingController.text,
                          isCompleted: false,
                          color: currentColor!.name,
                          reminder: reminderDateTime,
                          createdAt: DateTime.now()));
                } else {
                  EasyLoading.showToast(
                    'Veuillez entrer une tâche',
                    toastPosition: EasyLoadingToastPosition.top,
                    duration: const Duration(seconds: 2),
                    //maskType: EasyLoadingMaskType.black,
                  );
                }
              },
            ),
          ),
          Row(
            children: [
              Gap(10),
              ReminderPicker(
                onChanged: (value) {
                  log('Reminder: $value');
                  reminderDateTime = value;
                },
              ),
              Gap(5),
              PriorityColorSelector(
                onChanged: (value) {
                  if (value != null) {
                    currentColor = value;
                  }
                },
              )
            ],
          ),
          Gap(MediaQuery.of(context).viewInsets.bottom)
        ],
      ),
    );
  }
}
