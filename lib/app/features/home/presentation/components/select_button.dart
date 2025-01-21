import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_state.dart';

class SelectButton extends StatefulWidget {
  const SelectButton({super.key});

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckModeCubit, CheckModeState>(
      builder: (context, state) {
        return (state is CHECK_TASK_LIST)
            ? Checkbox(
                value: state.allSelected ?? false,
                onChanged: (bool? value) {
                  if (state.allSelected == true) {
                    context.read<CheckModeCubit>().deSelectAll();
                  } else {
                    context.read<CheckModeCubit>().selectAll();
                  }
                })
            : IconButton(
                onPressed: () {
                  context.read<CheckModeCubit>().statedCheck();
                },
                icon: Icon(FontAwesomeIcons.trashCan),
              );
      },
    );
  }
}
