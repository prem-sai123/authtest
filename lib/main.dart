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
          appBar: AppBar(
            title: const Text('User Authentication'),
            toolbarHeight: 50,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.pink, Colors.purple],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
            ),
          ),
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
