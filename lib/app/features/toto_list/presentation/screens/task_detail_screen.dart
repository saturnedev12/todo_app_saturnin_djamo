import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saturne_todo_app_djamo/app/core/config/injectable_config.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/data/models/task_model.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_logic.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_state.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/add_sub_task_compoent.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/components/sub_task_list.dart';
import 'package:timeago/timeago.dart' as timeago;

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController textEditingController;
  final taskListLogic = getIt<TaskListLogic>();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.taskModel.title);
    // _focusNode.addListener(
    //   () {
    //     if (!_focusNode.hasFocus) {
    //       //Navigator.pop(context);
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                title: Text('Détail de la tâche'),
                floating: false,
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  // isThreeLine: true,
                  titleAlignment: ListTileTitleAlignment.top,
                  minLeadingWidth: 0,
                  horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.symmetric(horizontal: 3),
                  leading: IconButton(
                    onPressed: () async {
                      widget.taskModel.isCompleted =
                          !widget.taskModel.isCompleted;
                      context.read<TaskListCubit>().updateTask(TaskEntity(
                            id: widget.taskModel.id,
                            title: textEditingController.text,
                            isCompleted: widget.taskModel.isCompleted,
                            createdAt: widget.taskModel.createdAt,
                          ));
                    },
                    icon: Icon(
                      widget.taskModel.isCompleted
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 35,
                    ),
                  ),
                  title: CupertinoTextField(
                    // focusNode: _focusNode,
                    controller: textEditingController,

                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    minLines: 1,
                    maxLines: 5,
                    autofocus: false,
                    placeholder: 'Entrez une tâche',

                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        decoration: widget.taskModel.isCompleted
                            ? TextDecoration.lineThrough
                            : null),
                    decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.none)),
                    onChanged: (value) {
                      context.read<TaskListCubit>().updateTask(TaskEntity(
                            id: widget.taskModel.id,
                            title: value,
                            isCompleted: widget.taskModel.isCompleted,
                            createdAt: widget.taskModel.createdAt,
                          ));
                    },
                    onEditingComplete: () {
                      context.read<TaskListCubit>().updateTask(TaskEntity(
                            id: widget.taskModel.id,
                            title: textEditingController.text,
                            isCompleted: widget.taskModel.isCompleted,
                            createdAt: widget.taskModel.createdAt,
                          ));
                    },
                  ),
                  titleTextStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                          decoration: widget.taskModel.isCompleted
                              ? TextDecoration.lineThrough
                              : null),
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  indent: 40,
                  endIndent: 10,
                ),
              ),
              ListSubTask(
                taskModel: widget.taskModel,
              ),
              SliverToBoxAdapter(
                child: AddSubTaskCompoent(
                  taskModel: widget.taskModel,
                ),
              )
            ],
          ),
          bottomSheet: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(timeago.format(widget.taskModel.createdAt)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.trashCan),
                  color: Colors.red,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
