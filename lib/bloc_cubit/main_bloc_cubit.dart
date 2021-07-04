import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/bloc_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/archived_tasks_screen.dart';
import 'package:todo_app/screens/done_tasks_screen.dart';
import 'package:todo_app/screens/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit getObj(context) => BlocProvider.of<AppCubit>(context);

  int selectedIndex = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isBottomSheetShown = false;
  Database database;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  List<Widget> screens = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void onBottomNavBarPressed(int index) {
    selectedIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void clearControllers() {
    titleController.clear();
    timeController.clear();
    dateController.clear();
  }

  createDataBase() {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,time TEXT, date TEXT,status TEXT)')
            .then((value) {
          print('Tables Created');
        }).catchError((error) {
          print('error while creating tables ${error.toString()}');
        });

        // try {
        //   await database.execute(
        //       'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,time TEXT, date TEXT,status TEXT)');
        //        print('Tables Created');
        // } catch (error) {
        //   print('error while creating tables ${error.toString()}');
        // }
      },
      onOpen: (database) {
        print('Database opened');
        getTasksFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  insertToDatabase() async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,time,date,status) VALUES ("${titleController.text}","${timeController.text}","${dateController.text}","new")')
          .then((value) {
        print(' $value Inserted successfully');
        emit(InsertToDatabaseState());

        getTasksFromDatabase(database);
      }).catchError((error) {
        print(' Error while inserting new record ${error.toString()}');
      });
      return null;
    });
  }

  void getTasksFromDatabase(Database database) {
    // emit(LoadingState());
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('Select * FROM tasks').then((value) {
      print(value);
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
        emit(GetDataState());
      });
    });
  }

  void updateData({@required String status, @required int id}) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(UpdateDatabaseState());
      getTasksFromDatabase(database);
    });
  }

  void deleteData(int id) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(DeleteDataState());
      getTasksFromDatabase(database);
    });
  }

  void changeFABValue(bool val) {
    isBottomSheetShown = val;
    emit(ChangeFABState());
  }

  void assignTaskTimeVal(value, context) {
    timeController.text = value.format(context);
    emit(ChangeBottomNavBarState());
  }

  void assignTaskDateVal(value) {
    dateController.text = DateFormat.yMMMd().format(value);
    // DateFormat('yyyy-MMM-dd').format(value);
    emit(ChangeBottomNavBarState());
  }
}
