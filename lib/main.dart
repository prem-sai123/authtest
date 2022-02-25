import 'package:authtest/cubit/signincubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homepage.dart';

void main() async {
  runApp(
    BlocProvider(
      create: (context) => SignincubitCubit(),
      child: MaterialApp(
        title: 'My Auth Test',
        home: Scaffold(
          body: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SignincubitCubit(), child: const MyHomePage());
  }
}
