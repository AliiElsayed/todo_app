import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc_cubit/bloc_observer.dart';
import 'package:todo_app/bloc_cubit/main_bloc_cubit.dart';
import 'package:todo_app/screens/home.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AppCubit>(
        create: (context) => AppCubit()..createDataBase(),
        child: MyHomePage(),
      ),
    );
  }
}
