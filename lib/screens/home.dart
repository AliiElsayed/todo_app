import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc_cubit/main_bloc_cubit.dart';
import 'package:todo_app/bloc_cubit/states.dart';
import 'package:todo_app/widgets/used_text_form_field.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is InsertToDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        AppCubit usedCubit = AppCubit.getObj(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            leading: Icon(Icons.list),
            title: Text(
              usedCubit.titles[usedCubit.selectedIndex],
            ),
          ),
          body: usedCubit.screens[usedCubit.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: usedCubit.selectedIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline), label: 'Done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: 'Archived'),
            ],
            onTap: (int index) {
              usedCubit.onBottomNavBarPressed(index);
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: usedCubit.isBottomSheetShown
                ? Icon(Icons.add)
                : Icon(Icons.edit),
            onPressed: () {
              if (usedCubit.isBottomSheetShown) {
                if (formKey.currentState.validate()) {
                  usedCubit.insertToDatabase();
                }
              } else {
                usedCubit.changeFABValue(true);
                scaffoldKey.currentState
                    .showBottomSheet((context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          color: Colors.grey[100],
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Add New Task !.'),
                                SizedBox(height: 5.0,),
                                UsedTextFormField(
                                  controller: usedCubit.titleController,
                                  fieldLabel: 'Task Title',
                                  fieldPrefixIcon: Icons.title,
                                  boardType: TextInputType.text,
                                  isReadOnly: false,
                                  fieldValidate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Title must not be Empty ';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                UsedTextFormField(
                                  controller: usedCubit.timeController,
                                  fieldLabel: 'Task Time',
                                  fieldPrefixIcon: Icons.watch_later_outlined,
                                  boardType: TextInputType.datetime,
                                  isReadOnly: true,
                                  isCursorShowed: true,
                                  fieldValidate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Time must not be Empty ';
                                    }
                                    return null;
                                  },
                                  onFieldTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      print(
                                          '!!!!!!!!!!!!!!${value.format(context)}');
                                      usedCubit.assignTaskTimeVal(value, context);
                                    }).catchError((error) {
                                      print(
                                          'Error While choosing time : $error');
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                UsedTextFormField(
                                  controller: usedCubit.dateController,
                                  fieldLabel: 'Task Date',
                                  fieldPrefixIcon: Icons.calendar_today,
                                  boardType: TextInputType.datetime,
                                  isReadOnly: true,
                                  isCursorShowed: true,
                                  fieldValidate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Date must not be Empty ';
                                    }
                                    return null;
                                  },
                                  onFieldTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2100-01-20'),
                                    ).then((value) {
                                      print(
                                          '!!!!!!!!!!!!!!! ${DateFormat('yyyy-MMM-dd').format(value)}');
                                      usedCubit.assignTaskDateVal(value);
                                    }).catchError((error) {
                                      print(
                                          'Error While choosing time : $error');
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                    .closed
                    .then((value) {
                      usedCubit.clearControllers();
                      usedCubit.changeFABValue(false);
                    });
              }
            },
          ),
        );
      },
    );
  }
}
