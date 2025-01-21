import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/check_mode_cubit.dart';

class SelectHandlerHome extends StatelessWidget {
  const SelectHandlerHome({super.key, required this.numTask});
  final int numTask;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.grey,
      height: 50,
      child: Row(
        children: [
          Gap(8),
          InputChip(
            avatar: Icon(
              FontAwesomeIcons.trashCan,
              color: Colors.red,
            ),
            label: Text(
              'Supprimer $numTask tâches',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.red),
            ),
            onPressed: () {
              context.read<CheckModeCubit>().removeCheck(context);
            },
          ),
          Gap(10),
          InputChip(
            avatar: Icon(FontAwesomeIcons.xmark),
            label: Text('Annuler'),
            onPressed: () {
              context.read<CheckModeCubit>().initialization();
            },
          ),
        ],
      ),
    );
  }
}
