// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/sub_task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/sub_task_logic.dart';

class SubTaskItem extends StatefulWidget {
  const SubTaskItem(
      {super.key, required this.subTaskModel, required this.taskModel});
  final SubTaskModel subTaskModel;
  final TaskModel taskModel;
  @override
  State<SubTaskItem> createState() => _SubTaskItemState();
}

class _SubTaskItemState extends State<SubTaskItem> {
  final subTaskLogic = getIt<SubTaskLogic>();

  @override
  void initState() {
    super.initState();
    subTaskLogic.initSingle(
        taskModel: widget.taskModel, subTaskModel: widget.subTaskModel);
  }

  @override
  void dispose() {
    super.dispose();
    subTaskLogic.close();
  }

  @override
  Widget build(BuildContext context) {
    // Vérifie la hauteur du clavier en temps réel
    // double currentKeyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // if (currentKeyboardHeight == 0 && _keyboardHeight > 0) {
    //   // Le clavier vient de disparaître
    //   if (Navigator.of(context).canPop()) {
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //       Navigator.of(context).pop();
    //     });
    //   }

    //   // Future.delayed(Duration(seconds: 3), () {
    //   //   Navigator.of(context).pop();
    //   // });
    // }

    //_keyboardHeight = currentKeyboardHeight; //
    return ListTile(
      tileColor: Theme.of(context).scaffoldBackgroundColor,
      horizontalTitleGap: 0,
      minLeadingWidth: 0,
      leading: IconButton(
        onPressed: () async {
          // Inverser l'état de complétion
          await subTaskLogic.isarConfig.instance.writeTxn(() async {
            widget.subTaskModel.isCompleted = !widget.subTaskModel.isCompleted;
            await subTaskLogic.isarConfig.instance.subTaskModels
                .put(widget.subTaskModel);
          });
        },
        icon: Icon(
          widget.subTaskModel.isCompleted
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
        ),
      ),
      title: CupertinoTextField(
        focusNode: subTaskLogic.focusNode,
        controller: subTaskLogic.textEditingController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        // autofocus: true,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            decoration: widget.subTaskModel.isCompleted
                ? TextDecoration.lineThrough
                : null),
        placeholder: 'Entrez une sous tâche',
        decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.none),
            color: Theme.of(context).scaffoldBackgroundColor),
        onEditingComplete: () async {
          subTaskLogic.updatte(subTaskModel: widget.subTaskModel);
        },
      ),
      contentPadding: EdgeInsets.only(right: 0, left: 15),
      trailing: IconButton(
        iconSize: 18,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Supprimer la sous tâche'),
                    content: const Text(
                        'Êtes-vous sûr de vouloir supprimer cette sous tâche ?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await subTaskLogic.isarConfig.instance.writeTxn(
                            () async {
                              await subTaskLogic
                                  .isarConfig.instance.subTaskModels
                                  .delete(widget.subTaskModel.id);
                            },
                          );

                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Supprimer'),
                      ),
                    ],
                  ));
        },
        icon: Icon(FontAwesomeIcons.trashCan, color: Colors.red),
      ),
    );
  }
}
