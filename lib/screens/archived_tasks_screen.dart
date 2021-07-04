import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc_cubit/main_bloc_cubit.dart';
import 'package:todo_app/bloc_cubit/states.dart';
import 'package:todo_app/widgets/build_item.dart';
import 'package:todo_app/widgets/no_data_indicator.dart';
class ArchivedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppCubit.getObj(context).archivedTasks.length == 0
            ? NoDataIndicator(caption: 'No Archived Tasks',)
            : Container(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return BuildListItem(
                        taskItem: AppCubit.getObj(context).archivedTasks[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                        child: Divider(
                          height: 2,
                          thickness: 2.5,
                          color: Colors.grey[300],
                        ),
                      );
                    },
                    itemCount: AppCubit.getObj(context).archivedTasks.length),
              );
      },
    );
  }
}
