import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc_cubit/main_bloc_cubit.dart';
import 'package:todo_app/bloc_cubit/states.dart';
import 'package:todo_app/widgets/build_item.dart';
import 'package:todo_app/widgets/no_data_indicator.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is InitialState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: AppCubit.getObj(context).newTasks.length == 0
                    ? NoDataIndicator(
                        caption: 'No Tasks To show...\nStart adding Some ...',
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return BuildListItem(
                            taskItem: AppCubit.getObj(context).newTasks[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 10.0, end: 10.0),
                            child: Divider(
                              height: 2,
                              thickness: 2.5,
                              color: Colors.grey[300],
                            ),
                          );
                        },
                        itemCount: AppCubit.getObj(context).newTasks.length,
                      ),
              );
      },
    );
  }
}
