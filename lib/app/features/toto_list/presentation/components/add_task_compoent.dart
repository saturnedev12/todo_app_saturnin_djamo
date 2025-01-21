import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';

class AddTaskCompoent extends StatefulWidget {
  const AddTaskCompoent({super.key});

  @override
  State<AddTaskCompoent> createState() => _AddTaskCompoentState();
}

class _AddTaskCompoentState extends State<AddTaskCompoent> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController textEditingController;
  double _keyboardHeight = 0.0;

  @override
  void initState() {
    // TODO: implement initState
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
    // TODO: implement dispose
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
              decoration:
                  BoxDecoration(border: Border.all(style: BorderStyle.none)),
              onEditingComplete: () {
                log('DONE');
                if (textEditingController.text.isNotEmpty) {
                  Navigator.pop(
                      context,
                      TaskEntity(
                          title: textEditingController.text,
                          isCompleted: false,
                          createdAt: DateTime.now()));
                }
              },
            ),
          ),
          Row(
            spacing: 8,
            children: [
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell)),
              IconButton(
                  onPressed: () {}, icon: Icon(FontAwesomeIcons.alignLeft)),
              IconButton(
                  onPressed: () {}, icon: Icon(FontAwesomeIcons.palette)),
            ],
          ),
          Gap(MediaQuery.of(context).viewInsets.bottom)
        ],
      ),
    );
  }
}
